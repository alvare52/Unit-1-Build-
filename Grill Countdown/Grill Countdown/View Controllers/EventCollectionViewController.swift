//
//  EventCollectionViewController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

// Step 1
protocol EventCellDelegate {
    func updateLabels(passedEvent: Event)
    func updateCounter(passedEvent: Event)
}

class EventCollectionViewController: UICollectionViewController {
    
    var eventController: EventController = EventController()
    
    var timer: Timer?
    
    // Step 2
    var eventDelegate: EventCellDelegate?
       
    var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "hh:mm:ss"
       formatter.timeZone = TimeZone(secondsFromGMT: 0)
       return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer() // should only start when array isn't empty.
        // viewwillappear should startTimer() if array is empty but then you create one
        for event in eventController.events {
            print("\(event.date)")
        }
        
//        // add this to viewcell
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        //dateFormatter.timeZone = TimeZone(secondsFromGMT: -28800)
        dateFormatter.locale = Locale(identifier: "en_US")
        let displayedDate = Date()
        var realDate = Date()
        realDate.addTimeInterval(-28800)
        print("realDate is \(realDate)")
        print("displayedDate is \(displayedDate)")
        let displayedDateString = dateFormatter.string(from: displayedDate)
        let realDateString = dateFormatter.string(from: realDate)
        print("realDateString is \(realDateString)")
        print("displayedDateString is \(displayedDateString)")
        
        //sendNotification() not done
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
        RunLoop.current.add(timer!, forMode: .common)
        timer?.tolerance = 0.1 // ???
    }
    
    func sendNotification() {
        let note = UNMutableNotificationContent()
        note.title = "IT'S TIME TO GRILL!"
        note.body = "Start grillin for God's sake!"
        note.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "done", content: note, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func refreshCountdowns() {
        collectionView.reloadData()
        // was this breaking day formatter and (also commented out event.countdown in ECVC)
//        for visibleCell in collectionView.visibleCells {
//            guard let cell = visibleCell as? EventCollectionViewCell else { continue }
//            cell.updateViews()
//        }
    }
     
    
    // should check that array isn't empty
    func updateTimer(timer: Timer) {
        
        for currentEvent in eventController.events {
        
            //currentEvent.interval -= 1
            currentEvent.interval = currentEvent.date.timeIntervalSinceNow
            print("interval now \(currentEvent.interval)")
            print("event date is \(currentEvent.date)")
            print("Date() is \(Date())")
            eventDelegate?.updateCounter(passedEvent: currentEvent) // ?
            refreshCountdowns()
            collectionView.reloadData()
            
            // OLD way of checking, using dateFormatter that doesn't have dd:
            //if dateFormatter.string(from: currentEvent.date) <= dateFormatter.string(from: Date())
            if currentEvent.date <= Date() {
                print("\(currentEvent.title) \(currentEvent.tag) IS DONE")
                print("currentEvent: \(currentEvent.title)")
                sendNotification() // not done,
                showAlert(event: currentEvent) // uncomment later
                // Step 3
                eventDelegate?.updateLabels(passedEvent: currentEvent)
                // ADD THIS BACK LATER
                eventController.events.remove(at: eventController.events.firstIndex(of: currentEvent)!)
                refreshCountdowns()
                collectionView.reloadData()
                // if events.count is 0, then timer.invalidate(), timer = nil
            }
        }
    }
    
    func showAlert(event: Event) {
        let alert = UIAlertController(title: "IT'S TIME TO GRILL!", message: "Start grillin for God's sake!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
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
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.orange.cgColor
        
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
