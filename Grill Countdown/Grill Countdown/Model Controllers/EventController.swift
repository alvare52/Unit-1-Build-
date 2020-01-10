//
//  EventController.swift
//  Grill Countdown
//
//  Created by Jorge Alvarez on 1/7/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class EventController {
    var events: [Event] = [Event(title: "Test", tag: "Work", date: Date(timeIntervalSinceNow: 18)),
                            Event(title: "Homework", tag: "School", date: Date(timeIntervalSinceNow: 8))]

    init() {
      loadFromPersistentStore()
    }

    var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let itemsURL = documentsDir.appendingPathComponent("grillcountdown.plist")
        return itemsURL
    }

    func saveToPersistentStore() {
        guard let fileURL = persistentFileURL else {return}

        do {
            let encoder = PropertyListEncoder()
            let itemsData = try encoder.encode(events)
            try itemsData.write(to: fileURL)
        } catch {
            print("Error saving items: \(error)")
        }
    }

    func loadFromPersistentStore() {
        guard let fileURL = persistentFileURL else {return}

        do {
            let itemsData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let itemsArray = try decoder.decode([Event].self, from: itemsData)
            self.events = itemsArray
        } catch {
            print("Error loading items from plist: \(error)")
        }
    }
}
