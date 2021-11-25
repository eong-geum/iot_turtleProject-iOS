//
//  MainViewController.swift
//  eonggeum
//
//  Created by YOONJONG on 2021/10/11.
//

import UIKit
import NotificationCenter
import UserNotifications
import Firebase
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var turtleImageView: UIImageView!
    @IBOutlet weak var todayCountView: UIView!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var todayDetectedLabel: UILabel!
    @IBOutlet weak var compareToYesterdayLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    var uid:String?
    var counterDic: Dictionary<String, String> = Dictionary<String, String>()
    let ref = Database.database().reference()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToCalendar" {
            let vc = segue.destination as! CalendarViewController
            vc.counterDic = self.counterDic
        }
    }
    @IBAction func calendarButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "MainToCalendar", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        uid = "user1_UID" // sample test
        updateUI()
        firebaseOperationRead()
        calendarButton.isEnabled = false
    }
    
    func updateUI(){
        self.dateFormatter.dateFormat="yyyy-MM-dd"
        let today = self.dateFormatter.string(from: Date())
        let realm = try! Realm()
        let savedPersonData = realm.objects(Person.self)
        let filteredPersonData = savedPersonData.filter("uid=='\(self.uid!)' && date=='\(today)'")
        if filteredPersonData.count == 0 { // 저장된 data 없다면
            todayDetectedLabel.text = "데이터를 불러오는 중입니다."
            compareToYesterdayLabel.text = "데이터를 불러오는 중입니다."
        } else {
            let readData = filteredPersonData[0]
            todayDetectedLabel.text = "거북목 감지 \(readData.count!)회"
            compareToYesterdayLabel.text = "데이터를 불러오는 중입니다."
        }
        todayView.layer.cornerRadius = 20
        turtleImageView.layer.cornerRadius = 20
        todayCountView.layer.cornerRadius = 20
    }
}

extension MainViewController{
    func firebaseOperationRead(){
        ref.child("count").child("kangho").observeSingleEvent(of: .value) { snapshot in
            let val = snapshot.value! as! [String: [String: Any]]
            
            for (date, counter) in val{
//                print("\(date) -> \(counter)")
                let some = counter["count"] as! Int
                self.counterDic.updateValue(String(some), forKey: date)
            }

            self.calendarButton.isEnabled = true

            // Label update
            self.labelUpdate();
        }
    }
    func labelUpdate(){
        let calendar = Calendar.current
        let today = self.dateFormatter.string(from: Date())
        let yesterday = self.dateFormatter.string(from: calendar.date(byAdding:.day, value: -1, to: Date())!)
      
        if let todayCnt = self.counterDic[today] { // 오늘의 데이터가 존재한다면
            let todayCntInt = Int(todayCnt)!
            self.todayDetectedLabel.text = "거북목 감지 \(todayCnt)회"
            writeRealm(todayDate:today, todayCnt:todayCntInt)
            
            if let yesterdatyCnt = self.counterDic[yesterday] {
                let yesterdayCntInt = Int(yesterdatyCnt)!
                if (todayCntInt > yesterdayCntInt) {
                    self.compareToYesterdayLabel.text = "어제보다 \(todayCntInt-yesterdayCntInt)회 더 감지되었어요"
                } else if (todayCntInt == yesterdayCntInt) {
                    self.compareToYesterdayLabel.text = "어제랑 동일한 횟수예요!"
                } else {
                    self.compareToYesterdayLabel.text = "어제보다 \(yesterdayCntInt-todayCntInt)회 줄었어요"
                }

//                    print("=> ", yesterday, self.counterDic[yesterday]!)
            } else { // yesterday 데이터가 없다면, 0으로 가정
                self.compareToYesterdayLabel.text = "어제보다 \(todayCntInt)회 더 감지되었어요"
            }
            
//                print("==> ", today, self.counterDic[today]!)
        } else {
            self.todayDetectedLabel.text = "오늘은 거북목이 감지되지 않았어요!"
            self.compareToYesterdayLabel.text = "카메라를 키지 않았다면 카메라를 켜주세요."
        }
    }
    
    // firebase Realtime DB에서 데이터 수집시 실행됨.
    func writeRealm(todayDate:String, todayCnt:Int){ // 오늘의 데이터만 수정
        let realm = try! Realm()
        let savedPersonData = realm.objects(Person.self)
        let filteredPersonData = savedPersonData.filter("uid=='\(self.uid!)' && date=='\(todayDate)'")
        if filteredPersonData.count == 0 { // 오늘의 데이터가 현 디비에 없다면
            let newUserData = Person()
            newUserData.uid = uid!
            newUserData.count = todayCnt
            newUserData.date = todayDate
            try! realm.write{
                realm.add(newUserData)
            }
        } else { // 오늘의 데이터가 현 디비에 있다면
            let dataToUpdate = filteredPersonData[0]
            try! realm.write{
                dataToUpdate.count = todayCnt
            }
        }
        
    }
}
