//
//  SettingsController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/9/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class SettingsController {
    
    var settingsArray: [Setting] {
        let settings = [Setting(title: "Show Seconds", isSelected: true, key: "Seconds")]
        
        for setting in settings {
            let shouldShowInc = UserDefaults.standard.bool(forKey: setting.key)
            setting.isSelected = shouldShowInc
        }
        return settings
    }
    
    var orderArray: [Setting] {
        let settings = [Setting(title: "First to finish", isSelected: true, key: "ShouldShowRecentsLast")]
        
        let shouldShowRecentsLast = UserDefaults.standard.bool(forKey: settings[0].key)
        settings[0].isSelected = shouldShowRecentsLast
        
        return settings
    }
}
