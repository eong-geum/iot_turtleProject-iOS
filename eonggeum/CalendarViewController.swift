//
//  CalendarViewController.swift
//  eonggeum
//
//  Created by YOONJONG on 2021/10/12.
//

import UIKit
import FSCalendar
class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        UIUpdate()
    }
    
    func UIUpdate(){
        calendarView.appearance.todayColor = UIColor(red: 7/255, green: 181/255, blue: 129/255, alpha: 1)
        calendarView.allowsSelection = false
        calendarView.appearance.headerTitleColor = .black
        calendarView.appearance.weekdayTextColor = .black
        calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        calendarView.appearance.titleWeekendColor = UIColor(red: 7/255, green: 181/255, blue: 129/255, alpha: 1)
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.locale = Locale(identifier: "ko_KR")
    }
    

}
extension CalendarViewController :FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        switch dateFormatter.string(from: date){
        case dateFormatter.string(from: Date()):
            return "4"
        case "2021-10-11":
            return "17"
        case "2021-10-10":
            return "15"
        case "2021-10-09":
            return "18"
        default:
            return nil
        }
    }
}
