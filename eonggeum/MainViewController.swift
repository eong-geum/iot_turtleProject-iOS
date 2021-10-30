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

class MainViewController: UIViewController {

    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var turtleImageView: UIImageView!
    @IBOutlet weak var todayCountView: UIView!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var todayDetectedLabel: UILabel!
    @IBOutlet weak var compareToYesterdayLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    
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
        updateUI()
        firebaseOperationRead()
        calendarButton.isEnabled = false
    }
    
    func updateUI(){
        todayDetectedLabel.text = "데이터를 불러오는 중입니다."
        compareToYesterdayLabel.text = "데이터를 불러오는 중입니다."
        todayView.layer.cornerRadius = 20
        turtleImageView.layer.cornerRadius = 20
        todayCountView.layer.cornerRadius = 20
//        todayCountView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
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
            print("MainVC : ", self.counterDic)
            let orderedDic = self.counterDic.sorted(by: <)
            print("orderedDic : ", orderedDic)
            self.calendarButton.isEnabled = true
            
            self.dateFormatter.dateFormat="yyyy-MM-dd"
            let calendar = Calendar.current
            let today = self.dateFormatter.string(from: Date())
            let yesterday = self.dateFormatter.string(from: calendar.date(byAdding:.day, value: -1, to: Date())!)
            
            // Label update
            if let todayCnt = self.counterDic[today] {
                let todayCntInt = Int(todayCnt)!
                self.todayDetectedLabel.text = "거북목 감지 \(todayCnt)회"
                if let yesterdatyCnt = self.counterDic[yesterday] {
                    let yesterdayCntInt = Int(yesterdatyCnt)!
                    if (todayCntInt > yesterdayCntInt) {
                        self.compareToYesterdayLabel.text = "어제보다 \(todayCntInt-yesterdayCntInt)회 더 감지되었어요"
                    } else if (todayCntInt == yesterdayCntInt) {
                        self.compareToYesterdayLabel.text = "어제랑 동일한 횟수예요!"
                    } else {
                        self.compareToYesterdayLabel.text = "어제보다 \(todayCntInt-yesterdayCntInt)회 줄었어요"
                    }
                } else { // yesterday 데이터가 없다면, 0으로 가정
                    self.compareToYesterdayLabel.text = "어제보다 \(todayCntInt)회 더 감지되었어요"
                }
            } else {
                self.todayDetectedLabel.text = "오늘은 거북목이 감지되지 않았어요!"
            }
            
            
            print("==> ", today, self.counterDic[today]!)
            print("=> ", yesterday, self.counterDic[yesterday]!)
            
            
        }
    }
}
