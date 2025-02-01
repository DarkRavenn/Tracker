//
//  TrackerModel.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 27.10.2024.
//

import UIKit

// Структура для хранения информации о привычках
struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let schedule: [Weekday]
}

enum Weekday: Int {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}
