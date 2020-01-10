//
//  EventCollectionViewCell.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! // title + tag of event
    @IBOutlet weak var tagLabel: UILabel! // date when it will finish
    @IBOutlet weak var countDownLabel: UILabel!
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
        //formatter.timeZone = TimeZone(secondsFromGMT: 0) // this was breaking label
        return formatter
    }()
    
    var countdownFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:HH:mm:ss" // hh was adding 12
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = ":HH:mm:ss" // hh was adding 12
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var delegate: EventCellDelegate?
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let event = event else {return}
        titleLabel.text = event.title + " - " + event.tag
        //tagLabel.text = event.tag
        print("TAGLABEL is \(dateFormatter.string(from: event.date))")
        //let fakeLabel = event.date
        //print("fake label is \(fakeLabel)")
        tagLabel.text = dateFormatter.string(from: event.date)
        countDownLabel.text = event.countdown
        
        print(event.title)
    }
    
}

// Step 5
extension EventCollectionViewCell: EventCellDelegate {
    func updateLabels(passedEvent: Event) {
        passedEvent.title = "DONE"
        updateViews()
    }
    
    func updateCounter(passedEvent: Event) {
        let date = Date(timeIntervalSinceReferenceDate: passedEvent.interval)
        // used to be .tag
        
        // ADD BACK IF NEEDED
        //passedEvent.countdown = "\(countdownFormatter.string(from: date))"
        
        
        countDownLabel.text = "\(countdownFormatter.string(from: date))"
        
        print("COUNTDOWNLABEL.TEXT = \(dayFormatter.string(from: date))")
        let testString = countdownFormatter.string(from: date)
        print("test string is \(testString)")
        
        
        //let fixedString = fixDay(string: testString) + dayFormatter.string(from: date)
        let fixedString = correctDay(secs: passedEvent.interval) + dayFormatter.string(from: date) // ?
        
        print("FIXED")
        print(fixedString)
        passedEvent.countdown = fixedString
        
    }
    
    // takes in seconds and returns that amount in days
    func correctDay(secs: Double) -> String {
        
        var day = ""
        let secsInDay: Int = 86400
        
        switch Int(secs) {
        case 0..<secsInDay:
            day = "00"
        case secsInDay..<secsInDay*2:
            day = "01"
        case secsInDay*2..<secsInDay*3:
            day = "02"
        case secsInDay*3..<secsInDay*4:
            day = "03"
        case secsInDay*4..<secsInDay*5:
            day = "04"
        case secsInDay*5..<secsInDay*6:
            day = "05"
        case secsInDay*6..<secsInDay*7:
            day = "06"
        case secsInDay*7..<secsInDay*8:
            day = "07"
        case secsInDay*8..<secsInDay*9:
            day = "08"
        case secsInDay*9..<secsInDay*10:
            day = "09"
        case secsInDay*10..<secsInDay*11:
            day = "10"
        case secsInDay*11..<secsInDay*12:
            day = "11"
        case secsInDay*12..<secsInDay*13:
            day = "12"
        case secsInDay*13..<secsInDay*14:
            day = "13"
        case secsInDay*14..<secsInDay*15:
            day = "14"
        case secsInDay*15..<secsInDay*16:
            day = "15"
        case secsInDay*16..<secsInDay*17:
            day = "16"
        case secsInDay*17..<secsInDay*18:
            day = "17"
        case secsInDay*18..<secsInDay*19:
            day = "18"
        case secsInDay*19..<secsInDay*20:
            day = "19"
        case secsInDay*20..<secsInDay*21:
            day = "20"
        case secsInDay*21..<secsInDay*22:
            day = "21"
        case secsInDay*22..<secsInDay*23:
            day = "22"
        case secsInDay*23..<secsInDay*24:
            day = "23"
        case secsInDay*24..<secsInDay*25:
            day = "24"
        case secsInDay*25..<secsInDay*26:
            day = "25"
        case secsInDay*26..<secsInDay*27:
            day = "26"
        case secsInDay*27..<secsInDay*28:
            day = "27"
        case secsInDay*28..<secsInDay*29:
            day = "28"
        case secsInDay*29..<secsInDay*30:
            day = "29"
        case secsInDay*30..<secsInDay*31:
            day = "30"
        case secsInDay*31..<secsInDay*32:
            day = "31"
        // kill me
        default:
            day = "+31"
        }
        
        return day
    }
    
    // Takes incorrect days left and returns string that is minus 1 day (01 -> 00)
//    func fixDay(string: String) -> String {
//        var day = string.prefix(2)
//
//        print("day was \(day)")
//
//        let numDay = Int("\(day)")
//        if numDay != 0 {
//            day = "\(numDay! - 1)"
//        }
//        else {
//            day = "\(day)"
//        }
//
//        switch day {
//        case "0","1","2","3","4","5","6","7","8","9":
//            day = "0" + "\(day)"
//        default:
//            break
//        }
//        print("DAY IS NOW \(day)")
//        return "\(day)"
//    }
}
