//
//  ResultsViewController.swift
//  DateIntervals
//
//  Copyright © 2017 UnnamedGreenCompany. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ResultsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
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
        
        statusLabel.font = statusLabel.font.withSize(48)
        statusLabel.text = "Status: Calculating..."
        
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
        let filename = generateFileName()
        let downloadError = saveFile(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + filename)
        if downloadError == nil {
            alert(title: "Download Success", message: "Successfully downloaded to your Documents folder as " + filename)
        }
        else {
            alert(title: "Download Failed", message: downloadError!)
        }
    }
    
    @IBAction func onSendEmail(_ sender: UIButton) {
        //Check to see the device can send email.
        if( MFMailComposeViewController.canSendMail() ) {
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self

            mailComposer.setSubject("DateIntervals App Data")
            mailComposer.setMessageBody("See attachment.", isHTML: false)
            
            let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
            let filename = generateFileName()
            let fullpath = path + filename
            let saveError = saveFile(path: path + filename)
            if (saveError != nil) {
                alert(title: "Unable to save file; cannot send email.", message: saveError!)
                return
            }
            let fileData = NSData(contentsOfFile: fullpath)
            mailComposer.addAttachmentData(fileData! as Data, mimeType: "text/csv", fileName: filename)
            self.present(mailComposer, animated: true, completion: nil)
        }
        else {
            alert(title: "Mail Error", message: "Unfortunately, this device is not set up properly to send email.")
        }
    }
    
    @IBAction func onBackClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {});
    }
    
    func saveFile(path: String) -> String? {
        let contents = generateCsvString()
        do {
            try contents.write(toFile: path, atomically: true, encoding: .utf8)
            return nil
        }
        catch {
            return "\(error)"
        }
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
