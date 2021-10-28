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
            self.calendarButton.isEnabled = true
        }
    }
}
