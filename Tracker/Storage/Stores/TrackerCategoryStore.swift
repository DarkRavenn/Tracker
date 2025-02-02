//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 24.01.2025.
//

import UIKit
import CoreData

final class TrackerCategoryStore {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func add(_ trackerCategory: TrackerCategory) throws {
        let managedRecord = TrackerCategoryCoreData(context: context)
        managedRecord.title = trackerCategory.title
        try context.save()
    }
    
    func delete(_ tracker: NSManagedObject) throws {
        context.delete(tracker)
        try context.save()
    }
}
