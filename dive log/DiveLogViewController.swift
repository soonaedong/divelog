//
//  DiveLogViewController.swift
//  dive log
//
//  Created by max on 22/12/2018.
//  Copyright © 2018 shc. All rights reserved.
//

import UIKit
import os.log

class DiveLogViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
   

    @IBOutlet weak var siteTextField: UITextField!
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    
    var diveLog: DiveLog?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddDiveLogMode = presentingViewController is UINavigationController
        
        if isPresentingInAddDiveLogMode{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("ERROR")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("save button not pressed, not save", log: OSLog.default, type:.debug)
            return
        }
        
        let site = siteTextField.text ?? ""
        let date = datePicker.date
        let time = timePicker.date
        
        diveLog = DiveLog(site: site, date: date, time: time)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.datePicker.date = NSDate.init(timeIntervalSinceNow: 0) as Date
        self.timePicker.datePickerMode = UIDatePicker.Mode.countDownTimer
        
        siteTextField.delegate = self
        
        if let diveLog = diveLog {
            navigationItem.title = diveLog.site
            siteTextField.text = diveLog.site
            datePicker.date = diveLog.date
            timePicker.date = diveLog.time
        }
        
        updateSaveButtonState()
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func updateSaveButtonState() {
        let site = siteTextField.text ?? ""
        saveButton.isEnabled = !site.isEmpty
    }
    

    

}

