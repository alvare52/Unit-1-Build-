//
//  SettingsTableViewCell.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/9/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        guard let setting = setting else {return}
        
        setting.isSelected.toggle()
        if setting.title == "First to finish" {
            UserDefaults.standard.set(setting.isSelected, forKey: "ShouldShowRecentsLast")
        }
        
        if setting.title == "Show Seconds" {
            UserDefaults.standard.set(setting.isSelected, forKey: "Seconds")
        }
    }
    
    var setting: Setting? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let setting = setting else {return}
        titleLabel.text = setting.title
        switchOutlet.isOn = setting.isSelected
    }
    
}
