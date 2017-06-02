//
//  ResultsViewController.swift
//  DateIntervals
//
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
            let tableController: TableViewController = self.storyboard?.instantiateViewController(withIdentifier: "table") as! TableViewController
            tableController.results = results
            self.present(tableController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onDownload(_ sender: UIButton) {
        //Proof of concept. TODO the real thing
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let filename = "output.txt"
        
        // Set the data we want to write
        let contents = "Lorem ipsum dolor sit amet"
            
        // Write it to the file
        do {
            try contents.write(toFile: path + filename, atomically: true, encoding: .utf8)
            alert(title: "Download Success", message: "Successfully downloaded to your Documents folder as " + filename)
        }
        catch {
            alert(title: "LUL", message: "\(error)")
        }
    }
    
    @IBAction func onSendEmail(_ sender: UIButton) {
    }
    
    @IBAction func onBackClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {});
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
