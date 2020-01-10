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
        formatter.dateFormat = "MMM dd, yyyy hh:mm:ss"
        //formatter.timeZone = TimeZone(secondsFromGMT: 0) // this was breaking label
        return formatter
    }()
    
    var countdownFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:HH:mm:ss" // hh was adding 12
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
        passedEvent.countdown = "\(countdownFormatter.string(from: date))"
        countDownLabel.text = "\(countdownFormatter.string(from: date))"
        //updateViews() //?
    }
}
