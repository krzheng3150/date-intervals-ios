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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle user input through delegate callbacks
        numIntervalsField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

