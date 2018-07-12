//
//  ReportViewController.swift
//  Healthee
//
//  Created by Dallin McConnell on 6/27/18.
//  Copyright © 2018 Dallin McConnell. All rights reserved.
//

import UIKit
import Foundation

class ReportViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var restaurantNameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet weak var problemTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        problemTextView.delegate = self
        let date = convertDateFormatter()
        dateTextField.text = date
        let time = convertTimeFormatter()
        timeTextField.text = time
    }

    
    @IBAction func timeTextFieldEditing(_ sender: UITextField) {
        let timePickerView: UIDatePicker = UIDatePicker()
        timePickerView.datePickerMode = UIDatePickerMode.time
        sender.inputView = timePickerView
        timePickerView.addTarget(self, action: #selector(ReportViewController.timePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    @IBAction func restaurantNameTextFieldEditing(_ sender: UITextField) {
        self.view.endEditing(true);
    }
    
    @IBAction func dateTextFieldEditing(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ReportViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        restaurantNameTextField.text = ""
        problemTextView.text = ""
        let date = convertDateFormatter()
        dateTextField.text = date
        let time = convertTimeFormatter()
        timeTextField.text = time
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    @objc func timePickerValueChanged(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.dateStyle = DateFormatter.Style.none
        timeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    func convertDateFormatter() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        //formatter.dateFormat = "MM-dd-yy"
        let result = formatter.string(from: date)
        return result
    }
    func convertTimeFormatter() -> String {
        let time = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        let result = formatter.string(from: time)
        return result
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


