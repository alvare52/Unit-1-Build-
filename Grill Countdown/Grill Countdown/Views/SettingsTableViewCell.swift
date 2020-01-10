//
//  SettingsTableViewCell.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/9/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    func didChangeSetting(setting: Setting)
}

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        print("switch tapped")
        guard let setting = setting else {return}
        setting.isSelected.toggle()
        
        if setting.title == "Recents Last" {
            UserDefaults.standard.set(setting.isSelected, forKey: "ShouldShowRecentsLast")
        }
        if setting.title == "Show Days" {
            UserDefaults.standard.set(setting.isSelected, forKey: "Days")
        }
        if setting.title == "Show Hours" {
            UserDefaults.standard.set(setting.isSelected, forKey: "Hours")
        }
        if setting.title == "Show Minutes" {
            UserDefaults.standard.set(setting.isSelected, forKey: "Minutes")
        }
        if setting.title == "Show Seconds" {
            UserDefaults.standard.set(setting.isSelected, forKey: "Seconds")
        }

        print("\(setting.title) is now \(setting.isSelected)")
    }
    
    var setting: Setting? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        print("updateViews called")
        guard let setting = setting else {return}
        titleLabel.text = setting.title
        switchOutlet.isOn = setting.isSelected
    }
    
}
