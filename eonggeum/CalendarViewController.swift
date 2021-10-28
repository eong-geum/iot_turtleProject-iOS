import UIKit
import FSCalendar
import AVFoundation
import AudioToolbox
import Firebase

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    
    var counterDic: Dictionary<String, String> = Dictionary<String, String>()
    
    let ref = Database.database().reference()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        UIUpdate()
        
        firebaseOperationRead()
        
    }
    
    func UIUpdate(){
        calendarView.appearance.todayColor = UIColor(red: 7/255, green: 181/255, blue: 129/255, alpha: 1)
        calendarView.allowsSelection = true
        
        calendarView.appearance.headerTitleColor = .black
        calendarView.appearance.weekdayTextColor = .black
        calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.appearance.titleWeekendColor = UIColor(red: 7/255, green: 181/255, blue: 129/255, alpha: 1)
        calendarView.appearance.titleFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        calendarView.appearance.subtitleFont = UIFont.systemFont(ofSize: 14, weight: .light)
        calendarView.appearance.subtitleOffset = CGPoint(x: 0, y: 3)
        calendarView.locale = Locale(identifier: "ko_KR")
        
    }
    

}
extension CalendarViewController :FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {

        if let data = counterDic[dateFormatter.string(from: date)] {
            return "\(data)회"
        } else { return nil}
//        return counterDic[dateFormatter.string(from: date)]
    }
    
}

extension CalendarViewController{
    
    func firebaseOperationRead(){
        ref.child("count").child("kangho").observeSingleEvent(of: .value) { snapshot in
            let val = snapshot.value! as! [String: [String: Any]]
            
            // put DB data into counterDic Dictionary
            for (date, counter) in val{
//                print("\(date) -> \(counter)")
                let some = counter["count"] as! Int
                self.counterDic.updateValue(String(some), forKey: date)
            }
//            print("result : ", self.counterDic)
            // update calendarView
            self.calendarView.reloadData()
        }
    }
}

