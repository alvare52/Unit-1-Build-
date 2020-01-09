//
//  EventCollectionViewCell.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var countdownFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "00" + ":HH:mm:ss"
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
        titleLabel.text = event.title
        tagLabel.text = event.tag
        countDownLabel.text = dateFormatter.string(from: event.date)
        print(event.title)
    }
    
}

// Step 5
extension EventCollectionViewCell: EventCellDelegate {
    func updateLabels(passedEvent: Event) {
        print("passedEvent title: \(passedEvent.title)")
        passedEvent.title = "DONE"
        
        updateViews()
        print("passedEvent title is now: \(passedEvent.title)")
        countDownLabel.text = "ALSO DONE"
    }
    
    func updateCounter(passedEvent: Event, passedDate: Date) {
        print("called updateCounter")
        //let date = Date(timeIntervalSinceReferenceDate: 9000)
        let date = Date(timeIntervalSinceReferenceDate: passedEvent.interval)
        let formattedDate = countdownFormatter.string(from: date)
        print("formattedDate is \(formattedDate)")
        passedEvent.tag = "\(countdownFormatter.string(from: date))"
        //passedEvent.tag = "\(countdownFormatter.string(from: passedEvent.tempDate))"
        updateViews()
    }
}
