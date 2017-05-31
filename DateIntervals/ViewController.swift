//
//  ViewController.swift
//  DateIntervals
//
//  Copyright © 2017 UnnamedGreenCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var startYearField: UIPickerView!
    @IBOutlet weak var startMonthField: UIPickerView!
    @IBOutlet weak var startDayField: UIPickerView!
    @IBOutlet weak var startHourField: UIPickerView!
    @IBOutlet weak var startMinuteField: UIPickerView!
    @IBOutlet weak var endYearField: UIPickerView!
    @IBOutlet weak var endMonthField: UIPickerView!
    @IBOutlet weak var endDayField: UIPickerView!
    @IBOutlet weak var endHourField: UIPickerView!
    @IBOutlet weak var endMinuteField: UIPickerView!
    @IBOutlet weak var numIntervalsField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle user input through delegate callbacks
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

