//
//  TrackerStore.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 24.01.2025.
//

import Foundation
import CoreData

enum TrackerStoreError: Error {
    case decodingErrorInvalidName
    case decodingErrorInvalidEmoji
}

final class TrackerStore {
    private let context: NSManagedObjectContext
    private let uiColorMarshalling = UIColorMarshalling()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchTracker() throws {
        let fetchRequest = TrackerCoreData.fetchRequest()
        let trackerFromCoreData = try context.fetch(fetchRequest)
        try trackerFromCoreData.map { try self.tracker(from: $0) }
    }
    
    func addNewTraker(_ tracker: Tracker) throws {
        let trackerCoreData = TrackerCoreData(context: context)
        trackerCoreData.name = tracker.name
        trackerCoreData.emoji = tracker.emoji
        trackerCoreData.color = uiColorMarshalling.hexString(from: tracker.color)
        do {
            try context.save()
        } catch {
            print("Ошибка при получении данных: \(error.localizedDescription)")
        }
    }
    
    func tracker(from trackerFromCoreData: TrackerCoreData) throws {
        guard let name = trackerFromCoreData.name else {
            throw TrackerStoreError.decodingErrorInvalidName
        }
        guard let emoji = trackerFromCoreData.emoji else {
            throw TrackerStoreError.decodingErrorInvalidEmoji
        }
        print("emoji: \(emoji) name: \(name)")
    }
}

