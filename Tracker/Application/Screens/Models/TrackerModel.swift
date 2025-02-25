//
//  TrackerModel.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 27.10.2024.
//

import UIKit

// Структура для хранения информации о привычках
struct Tracker {
    let id: String
    let name: String
    let color: UIColor
    let emoji: String
    let schedule: [Weekday]
    let category: String
    let computedCategory: String
    let isPinned: Bool
}

enum Weekday: Int, Codable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    var fullName: String {
        switch self {
        case .monday: return Resources.Strings.Schedule.Weekdays.mon
        case .tuesday: return Resources.Strings.Schedule.Weekdays.tue
        case .wednesday: return Resources.Strings.Schedule.Weekdays.wed
        case .thursday: return Resources.Strings.Schedule.Weekdays.thu
        case .friday: return Resources.Strings.Schedule.Weekdays.fri
        case .saturday: return Resources.Strings.Schedule.Weekdays.sat
        case .sunday: return Resources.Strings.Schedule.Weekdays.sun
        }
    }
    
    var shortName: String {
        switch self {
        case .monday: return Resources.Strings.TrackerCreation.Weekdays.mon
        case .tuesday: return Resources.Strings.TrackerCreation.Weekdays.tue
        case .wednesday: return Resources.Strings.TrackerCreation.Weekdays.wed
        case .thursday: return Resources.Strings.TrackerCreation.Weekdays.thu
        case .friday: return Resources.Strings.TrackerCreation.Weekdays.fri
        case .saturday: return Resources.Strings.TrackerCreation.Weekdays.sat
        case .sunday: return Resources.Strings.TrackerCreation.Weekdays.sun
        }
    }
}
