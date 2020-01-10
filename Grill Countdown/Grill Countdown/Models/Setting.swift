//
//  Setting.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/9/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class Setting {
    
    var title: String
    var isSelected: Bool
    var key: String
    
    init(title: String, isSelected: Bool, key: String) {
        self.title = title
        self.isSelected = isSelected
        self.key = key
    }
    
}
