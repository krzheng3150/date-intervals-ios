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
    @IBOutlet weak var zeroIndexLabel: UILabel!
    @IBOutlet weak var zeroIndexSwitch: UISwitch!
    
    var numIntervals: Int = 10
    var startDate: Date = Date()
    var endDate: Date = Date()
    var results: [String] = []
    
    var fileTitleDateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileTitleDateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        statusLabel.textAlignment = NSTextAlignment.center;
        statusLabel.font = statusLabel.font.withSize(48)
        statusLabel.text = "Status: Calculating..."
        zeroIndexLabel.textAlignment = NSTextAlignment.center;
        
        let startTime = startDate.timeIntervalSince1970
        let endTime = endDate.timeIntervalSince1970
        results.append(dateToDisplayString(date: startDate))
        for i in 1...numIntervals-1 {
            let d = Date(timeIntervalSince1970: startTime + ((endTime - startTime) / Double(numIntervals)) * Double(i))
            results.append(dateToDisplayString(date: d))
        }
        results.append(dateToDisplayString(date: endDate))
        
        statusLabel.text = "Status: Done!"
        
    }
    
    @IBAction func onViewResults(_ sender: UIButton) {
        if (numIntervals > 100) {
            alert(title: "Results Too Big", message: "Unfortunately, because there are more than 100 intervals, they will not be displayed. Please download or email them.")
        }
        else {
            let tableController: TableViewController = self.storyboard?.instantiateViewController(withIdentifier: "table") as! TableViewController
            tableController.results = results
            tableController.isZeroIndexed = zeroIndexSwitch.isOn
            self.present(tableController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onDownload(_ sender: UIButton) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filename = generateFileName()
        let contents = generateCsvString()
        do {
            try contents.write(toFile: path + filename, atomically: true, encoding: .utf8)
            alert(title: "Download Success", message: "Successfully downloaded to your Documents folder as " + filename)
        }
        catch {
            alert(title: "Download Failed", message: "\(error)")
        }
    }
    
    @IBAction func onSendEmail(_ sender: UIButton) {
    }
    
    @IBAction func onBackClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {});
    }
    
    func generateFileName() -> String {
        return "DateIntervals-" + fileTitleDateFormatter.string(from: Date()) + ".csv"
    }
    
    func generateCsvString() -> String {
        var fileStr = ""
        for i in 0...results.count-1 {
            fileStr.append(String(zeroIndexSwitch.isOn ? i : i+1) + "," + results[i] + "\n")
        }
        return fileStr
    }
    
    func dateToDisplayString(date: Date) -> String {
        let dateStr = date.description
        //We want to omit the time zone portion by taking the string up until the " +0000" part
        return dateStr.substring(to: dateStr.index(dateStr.endIndex, offsetBy: -6))
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
