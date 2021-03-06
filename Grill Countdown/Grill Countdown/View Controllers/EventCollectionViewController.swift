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
            eventController.saveToPersistentStore()
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

    /// Starts timer and loads data 
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        eventController.loadFromPersistentStore()
    }
    
    /// Checks the "Order" setting to display events accordingly
    override func viewWillAppear(_ animated: Bool) {
        if settingsController.orderArray[0].isSelected {
            orderEvents()
        }
        else {
            unOrderEvents()
        }
    }
    
    /// Main timer that is used to check all events being tracked
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
        RunLoop.current.add(timer!, forMode: .common)
        timer?.tolerance = 0.1
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
                sendNotification()
                showAlert(event: currentEvent)
                eventDelegate?.updateLabels(passedEvent: currentEvent)
                eventController.events.remove(at: eventController.events.firstIndex(of: currentEvent)!)
                eventController.saveToPersistentStore()
                refreshCountdowns()
                collectionView.reloadData()
            }
        }
    }
    
    func showAlert(event: Event) {
        let alert = UIAlertController(title: "IT'S TIME TO GRILL!", message: "Start grillin for God's sake!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

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
        eventController.saveToPersistentStore()
        orderEvents()
        collectionView.reloadData()
    }
}
