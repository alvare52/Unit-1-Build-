//
//  SettingsController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/9/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class SettingsController {
    var settingsArray: [Setting] = [Setting(title: "Show Days", isSelected: true),
                                    Setting(title: "Show Hours", isSelected: true),
                                    Setting(title: "Show Minutes", isSelected: true),
                                    Setting(title: "Show Seconds", isSelected: true)]
}
