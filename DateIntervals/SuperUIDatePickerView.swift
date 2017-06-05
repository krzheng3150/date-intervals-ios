//
//  SuperUIDatePickerView.swift
//  DateIntervals
//
//  Copyright © 2017 UnnamedGreenCompany. All rights reserved.
//

import Foundation
import UIKit

class SuperUIDatePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let MIN_YEAR = 1970
    let MAX_YEAR = 2037
    
    var years: [Int]!
    var months: [Int]!
    var days: [Int]!
    var hours: [Int]!
    var minutes: [Int]!
    
    var year: Int = 0 {
        didSet {
            selectRow(years.index(of: year)!, inComponent: 0, animated: true)
        }
    }
    
    var month: Int = 0 {
        didSet {
            selectRow(month-1, inComponent: 1, animated: false)
        }
    }
    
    var day: Int = 0 {
        didSet {
            selectRow(day-1, inComponent: 2, animated: false)
        }
    }
    
    var hour: Int = 0 {
        didSet {
            selectRow(hour, inComponent: 3, animated: false)
        }
    }
    
    var minute: Int = 0 {
        didSet {
            selectRow(minute, inComponent: 4, animated: false)
        }
    }
    
    var onDateSelected: ((_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {
        var years: [Int] = []
        for year in MIN_YEAR...MAX_YEAR {
            years.append(year)
        }
        self.years = years
        
        var months: [Int] = []
        for month in 1...12 {
            months.append(month)
        }
        self.months = months
        
        var days: [Int] = []
        for day in 1...31 {
            days.append(day)
        }
        self.days = days
        
        var hours: [Int] = []
        for hour in 0...23 {
            hours.append(hour)
        }
        self.hours = hours
        
        var minutes: [Int] = []
        for minute in 0...59 {
            minutes.append(minute)
        }
        self.minutes = minutes
        
        self.delegate = self
        self.dataSource = self
        
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        self.selectRow(currentMonth - 1, inComponent: 0, animated: false)
    }
    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(years[row])"
        case 1:
            return "\(months[row])"
        case 2:
            return "\(days[row])"
        case 3:
            return "\(hours[row])"
        case 4:
            return "\(minutes[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            return days.count
        case 3:
            return hours.count
        case 4:
            return minutes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        switch component {
        case 0:
            return CGFloat(self.bounds.width * 0.28)
        case 1:
            return CGFloat(self.bounds.width * 0.17)
        case 2:
            return CGFloat(self.bounds.width * 0.17)
        case 3:
            return CGFloat(self.bounds.width * 0.17)
        case 4:
            return CGFloat(self.bounds.width * 0.17)
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = years[self.selectedRow(inComponent: 0)]
        let month = self.selectedRow(inComponent: 1)+1
        let day = self.selectedRow(inComponent: 2)+1
        let hour = self.selectedRow(inComponent: 3)
        let minute = self.selectedRow(inComponent: 4)
        if let block = onDateSelected {
            block(year, month, day, hour, minute)
        }
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
    }
    
}
