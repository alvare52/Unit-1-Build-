//
//  EventCollectionViewController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/6/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

protocol EventCellDelegate {
    func updateLabels(passedEvent: Event)
    func updateCounter(passedEvent: Event)
}

class EventCollectionViewController: UICollectionViewController {
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        for event in eventController.events {
            eventController.events.remove(at: eventController.events.firstIndex(of: event)!)
            collectionView.reloadData()
        }
    }

    var eventController = EventController()
    var settingsController = SettingsController()
    var timer: Timer?
    
    var eventDelegate: EventCellDelegate?
       
    var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "hh:mm:ss"
       formatter.timeZone = TimeZone(secondsFromGMT: 0)
       return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        for event in eventController.events {
            print("\(event.date)")
        }
        //eventController.loadFromPersistentStore() // Later or viewWillAppear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if settingsController.orderArray[0].isSelected {
            orderEvents()
        }
        else {
            unOrderEvents()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
        RunLoop.current.add(timer!, forMode: .common)
        timer?.tolerance = 0.1 // ???
    }
    
    /// Will only run when app is not in the foreground
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
    }
     
    /// Returns and array of ordered events and starts with the event that is closest to finishing
    func orderEvents() {
        eventController.events.sort(by: { $0.interval < $1.interval })
    }
    
    func unOrderEvents() {
        eventController.events.sort(by: { $0.interval > $1.interval })
    }
    
    /// Updates all events, removes them when finished and displays alert (or notification)
    func updateTimer(timer: Timer) {
        
        for currentEvent in eventController.events {
        
            currentEvent.interval = currentEvent.date.timeIntervalSinceNow
            eventDelegate?.updateCounter(passedEvent: currentEvent) // ?
            refreshCountdowns()
            collectionView.reloadData()
            
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
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return eventController.events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCollectionViewCell else {return UICollectionViewCell()}
    
        let event = eventController.events[indexPath.item]
        cell.event = event
        // Step 4
        eventDelegate = cell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.orange.cgColor
        cell.layer.cornerRadius = 50.0 
        
        return cell
    }
    
}

extension EventCollectionViewController: AddEventDelegate {
    func didAddEvent(event: Event) {
        eventController.events.append(event)
        //eventController.saveToPersistentStore() // Later
        orderEvents()//?
        collectionView.reloadData()
    }
}
