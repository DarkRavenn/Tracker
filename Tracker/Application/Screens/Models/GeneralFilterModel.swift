//
//  GeneralFilterModel.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 26.02.2025.
//

import Foundation

enum GeneralFilter: String, CaseIterable {
    case all
    case today
    case done
    case undone
    
    var localized: String {
        switch self {
        case .all:
            return Resources.Strings.Trackers.Filters.all
        case .today:
            return Resources.Strings.Trackers.Filters.today
        case .done:
            return Resources.Strings.Trackers.Filters.done
        case .undone:
            return Resources.Strings.Trackers.Filters.undone
        }
    }
}
