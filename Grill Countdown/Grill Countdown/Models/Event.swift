//
//  Event.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class Event: Codable {
    var title: String
    var tag: String
    var date: Date // ?
    
    init(title: String, tag: String, date: Date) {
        self.title = title
        self.tag = tag
        self.date = date
    }
}
