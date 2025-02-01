//
//  DataProvider.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 01.02.2025.
//

import UIKit
import CoreData

final class DataProvider {
    private let context: NSManagedObjectContext
    
    let trackerCategory: TrackerCategoryStore
    let trackerRecord: TrackerRecordStore
    let tracker: TrackerStore
    
    init() {
        self.context = CoreDataStack.shared.context
        self.trackerCategory = TrackerCategoryStore(context: context)
        self.trackerRecord = TrackerRecordStore(context: context)
        self.tracker = TrackerStore(context: context)
    }
}
