//
//  Event.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

// NSCoding protocol?
class Event: Codable {
    
    var title: String
    var tag: String
    var date: Date
    var interval: TimeInterval
    var tempDate: Date
    
    init(title: String, tag: String, date: Date) {
        self.title = title
        self.tag = tag
        self.date = date
        self.interval = date.timeIntervalSinceNow //?
        print("interval for \(self.title) is \(self.interval)")
        self.tempDate = date
    }
}
