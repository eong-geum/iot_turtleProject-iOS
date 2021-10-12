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
        calendarView.allowsSelection = true
        calendarView.appearance.headerTitleColor = .black
        calendarView.appearance.weekdayTextColor = .black
        calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        calendarView.appearance.titleWeekendColor = UIColor(red: 7/255, green: 181/255, blue: 129/255, alpha: 1)
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.appearance.subtitleFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        calendarView.appearance.subtitleOffset = CGPoint(x: 0, y: 3)
        calendarView.locale = Locale(identifier: "ko_KR")
    }
    

}
extension CalendarViewController :FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        switch dateFormatter.string(from: date){
        case dateFormatter.string(from: Date()):
            return "4회"
        case "2021-10-12":
            return "17회"
        case "2021-10-11":
            return "13회"
        case "2021-10-10":
            return "15회"
        case "2021-10-09":
            return "18회"
        default:
            return nil
        }
    }
}
