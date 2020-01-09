//
//  AddEventViewController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/7/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//
// add alert saying "enter blah" if something is left blank

import UIKit

protocol AddEventDelegate {
    func didAddEvent(event: Event)
}

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    var addEventDelegate: AddEventDelegate?
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("Button Pressed")
        
        // testing, should be checking textfields // also date: used to be date: Date since blah
        addEventDelegate?.didAddEvent(event: Event(title: "TESTING", tag: "TESTING", date: datePicker.date))
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
