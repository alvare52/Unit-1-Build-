//
//  AddEventViewController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/7/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

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
        guard let title = titleTextField.text, let tag = tagTextField.text, !title.isEmpty, !tag.isEmpty else {return}
        
        addEventDelegate?.didAddEvent(event: Event(title: title, tag: tag, date: datePicker.date))
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
    }
    
}
