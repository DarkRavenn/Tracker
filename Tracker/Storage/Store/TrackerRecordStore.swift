//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 24.01.2025.
//

import Foundation
import CoreData

final class TrackerRecordStore {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
