//
//  EventCollectionViewController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"
// AddEventSegue

// Step 1
protocol EventCellDelegate {
    func updateLabels(passedEvent: Event)
    func updateCounter(passedEvent: Event, passedDate: Date)
}

class EventCollectionViewController: UICollectionViewController {
    
    var eventController: EventController = EventController()
    
    // Step 2
    var eventDelegate: EventCellDelegate?
    //var timer: Timer?
    var count: Double = 0.0
       
    var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "HH:mm:ss"
       return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for event in eventController.events {
            print("\(event.title)/\(event.tag)/\(dateFormatter.string(from: event.date))")
        }
        //self.timer = nil
        startTimers()
        startMainTimer()
    }
    
    func startTimers() {
        for _ in eventController.events {
            let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
        }
    }
    
    
//    func startTimer() {
//        print("Started timer, current time: \(dateFormatter.string(from: Date()))")
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
//    }
    
    func startMainTimer() {
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateMainTimer(timer:))
    }
    
    func updateMainTimer(timer: Timer) {
        //count += 1
        //let timeLeft: TimeInterval = 360.0
        //let date = Date(timeIntervalSinceReferenceDate: timeLeft)
        //print(dateFormatter.string(from: date))
        for event in eventController.events {
            
            event.tempDate -= 1
            event.interval -= 1
            print("tempDate is now: \(event.tempDate)")
            eventDelegate?.updateCounter(passedEvent: event, passedDate: event.date) // ?
            collectionView.reloadData()
        }
    }
    
    // func updateTimer(timer: Timer) {
    func updateTimer(timer: Timer) {
        
        for currentEvent in eventController.events {
        
            print("\(currentEvent.title) \(dateFormatter.string(from: currentEvent.date)) - \(dateFormatter.string(from: Date()))")
            if dateFormatter.string(from: currentEvent.date) <= dateFormatter.string(from: Date()) {
                print("\(currentEvent.title) \(currentEvent.tag) IS DONE")
                print("currentEvent: \(currentEvent.title)")
                // Step 3
                eventDelegate?.updateLabels(passedEvent: currentEvent)
                //eventController.events.remove(at: 1)
                collectionView.reloadData()
            }
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddEventSegue" {
            guard let addEventVC = segue.destination as? AddEventViewController else {return}
            addEventVC.addEventDelegate = self // makes EventCollectionVC employee of addEventVC
        }
        
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return eventController.events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCollectionViewCell else {return UICollectionViewCell()}
    
        let event = eventController.events[indexPath.item]
        cell.event = event
        // Step 4
        eventDelegate = cell
        return cell
    }
    
//    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroceryItemCell", for: indexPath) as? GroceryItemCollectionViewCell else {return UICollectionViewCell()}
//
//    let item = groceryItemController.groceryItems[indexPath.item]
//    cell.groceryItem = item
//    itemSelectionDelegate = cell
//    return cell

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension EventCollectionViewController: AddEventDelegate {
    func didAddEvent(event: Event) {
        eventController.events.append(event)
        collectionView.reloadData()
    }
}
