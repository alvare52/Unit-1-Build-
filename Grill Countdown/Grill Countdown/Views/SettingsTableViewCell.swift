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
        print("switch tapped")
    }
    
    var setting: Setting? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        print("updateViews called")
        titleLabel.text = setting?.title
    }
    
}
