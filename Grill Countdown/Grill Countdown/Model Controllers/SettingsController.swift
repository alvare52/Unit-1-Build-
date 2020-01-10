//
//  SettingsController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/9/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class SettingsController {
//    var settingsArray: [Setting] = [Setting(title: "Show Days", isSelected: true),
//                                    Setting(title: "Show Hours", isSelected: true),
//                                    Setting(title: "Show Minutes", isSelected: true),
//                                    Setting(title: "Show Seconds", isSelected: true)]
//
//    var orderArray: [Setting] = [Setting(title: "Recents Last", isSelected: true)]
    
    var settingsArray: [Setting] {
        var settings = [Setting(title: "Show Days", isSelected: true, key: "Days"),
                        Setting(title: "Show Hours", isSelected: true, key: "Hours"),
                        Setting(title: "Show Minutes", isSelected: true, key: "Minutes"),
                        Setting(title: "Show Seconds", isSelected: true, key: "Seconds")]
        
        for setting in settings {
            let shouldShowInc = UserDefaults.standard.bool(forKey: setting.key)
            setting.isSelected = shouldShowInc
        }
        return settings
    }
    
    var orderArray: [Setting] {
        var settings = [Setting(title: "Recents Last", isSelected: true, key: "ShouldShowRecentsLast")]
        
        let shouldShowRecentsLast = UserDefaults.standard.bool(forKey: settings[0].key)
        settings[0].isSelected = shouldShowRecentsLast
        
        print("order.isSelected is \(settings[0].isSelected)")
        return settings
    }
}
