//
//  EventController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/7/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class EventController {
    var events: [Event] = [Event(title: "Test", tag: "Work", date: Date(timeIntervalSinceNow: 5))]
//    var events: [Event] = [Event(title: "Test", tag: "Work", date: Date()),
//                           Event(title: "Homework", tag: "School", date: Date()),
//                           Event(title: "Wedding", tag: "Family", date: Date()),
//                           Event(title: "Read", tag: "Self", date: Date()),
//                            Event(title: "Bar", tag: "Friends", date: Date()),
//                            Event(title: "Gym", tag: "Health", date: Date())
//                            ]
    
    
//    var timer: Timer?
//    var count = 0
//
//    var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm:ss"
//        return formatter
//    }()
    
//    init() {
//        for event in events {
//            print("\(event.title)/\(event.tag)/\(dateFormatter.string(from: event.date))")
//        }
//        self.timer = nil
//        startTimer()
//    }
    
//    func startTimer() {
//        print("Started timer, current time: \(dateFormatter.string(from: Date()))")
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
//    }
//    
//    func updateTimer(timer: Timer) {
//        count += 1
//        print("\(count) current date = \(dateFormatter.string(from: Date()))")
//        if dateFormatter.string(from: events[0].date) <= dateFormatter.string(from: Date()) {
//            print("SET DATE = CURRENT DATE")
//        }
//        
//        if count == 300 {
//            //guard let timer = self.timer else {return}
//            self.timer?.invalidate()
//            print("Stopped Timer")
//        }
//    }
//    
    // var fileManager {}
    // func saveFromPersistentStore
    // func loadFromPersistentStore
}
