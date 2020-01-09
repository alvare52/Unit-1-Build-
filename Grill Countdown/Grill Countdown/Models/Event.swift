//
//  Event.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

// NSCoding protocol?
class Event: Codable, Equatable {
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.title == rhs.title && lhs.tag == rhs.tag
    }
    
    var title: String
    var tag: String
    var date: Date
    var interval: TimeInterval
    //var lastDate: Date
    
    init(title: String, tag: String, date: Date) {
        self.title = title
        self.tag = tag
        self.date = date
        self.interval = date.timeIntervalSinceNow
        //self.lastDate = date - self.interval
        //print()
    }
}
