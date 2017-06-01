//
//  ViewController.swift
//  DateIntervals
//
//  Copyright © 2017 UnnamedGreenCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var numIntervalsField: UITextField!
    @IBOutlet weak var startDateField: SuperUIDatePickerView!
    @IBOutlet weak var endDateField: SuperUIDatePickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    let TIME_ZONE = TimeZone(abbreviation: "UTC")
    
    @IBAction func onSubmit(_ sender: UIButton)
    {
        //validate number of intervals
        let numIntervals: Int? = Int(numIntervalsField.text!)
        if (numIntervals == nil) {
            alert(title: "Number of Intervals", message: "Please enter an integer.")
            return
        }
        else if (numIntervals! < 2 || numIntervals! > 9000) {
            alert(title: "Number of Intervals", message: "The number should be between 2 and 9000.")
            return
        }
        
        var startDateComponents = DateComponents()
        startDateComponents.year = startDateField.year
        startDateComponents.month = startDateField.month
        startDateComponents.day = startDateField.day
        startDateComponents.hour = startDateField.hour
        startDateComponents.minute = startDateField.minute
        startDateComponents.timeZone = TIME_ZONE
        
        let userCalendar = Calendar.current
        let startDate = userCalendar.date(from: startDateComponents)
        
        var endDateComponents = DateComponents()
        endDateComponents.year = endDateField.year
        endDateComponents.month = endDateField.month
        endDateComponents.day = endDateField.day
        endDateComponents.hour = endDateField.hour
        endDateComponents.minute = endDateField.minute
        endDateComponents.timeZone = TIME_ZONE
        
        let endDate = userCalendar.date(from: endDateComponents)
        
        //validate dates
        if ((endDate)! < (startDate)!) {
            alert(title: "Start and End Dates", message: "End Date must be after Start Date.")
            return
        }
        
        let resultsController: ResultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "results") as! ResultsViewController
        resultsController.numIntervals = numIntervals!
        resultsController.startDate = startDate!
        resultsController.endDate = endDate!
        self.present(resultsController, animated: true, completion: nil)
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle user input through delegate callbacks
        numIntervalsField.delegate = self
        
        let date = Date()
        let calendar = Calendar.current
        
        startDateField.year = calendar.component(.year, from: date)
        startDateField.month = calendar.component(.month, from: date)
        startDateField.day = calendar.component(.day, from: date)
        startDateField.hour = 0
        startDateField.minute = 0
        
        endDateField.year = startDateField.year + 1
        endDateField.month = startDateField.month
        endDateField.day = startDateField.day
        endDateField.hour = 0
        endDateField.minute = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

