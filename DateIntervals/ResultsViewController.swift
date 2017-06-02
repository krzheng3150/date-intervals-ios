//
//  ResultsViewController.swift
//  DateIntervals
//
//  Created by ZhengFamily on 01/06/2017.
//  Copyright © 2017 UnnamedGreenCompany. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var numIntervals: Int = 10
    var startDate: Date = Date()
    var endDate: Date = Date()
    var results: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.textAlignment = NSTextAlignment.center;
        statusLabel.font = statusLabel.font.withSize(48)
        statusLabel.text = "Status: Calculating..."
        
        let startTime = startDate.timeIntervalSince1970
        let endTime = endDate.timeIntervalSince1970
        results.append(startDate)
        for i in 1...numIntervals-1 {
            results.append(Date(timeIntervalSince1970: startTime + ((endTime - startTime) / Double(numIntervals)) * Double(i)))
        }
        results.append(endDate)
        
        statusLabel.text = "Status: Done!"
        
    }
    
    @IBAction func onViewResults(_ sender: UIButton) {
        if (numIntervals > 100) {
            alert(title: "Results Too Big", message: "Unfortunately, because there are more than 100 intervals, they will not be displayed. Please download or email them.")
        }
        else {
            
        }
    }
    
    @IBAction func onDownload(_ sender: UIButton) {
    }
    
    @IBAction func onSendEmail(_ sender: UIButton) {
    }
    
    @IBAction func onBackClick(_ sender: UIButton) {
        //This method needs to be here even if empty, but it has been set to go back to main screen via controller
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
