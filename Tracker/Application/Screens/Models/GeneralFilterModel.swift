//
//  GeneralFilterModel.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 26.02.2025.
//

import Foundation

enum GeneralFilter: String, CaseIterable {
    case all = "Все трекеры"
    case today = "Трекеры на сегодня"
    case done = "Завершенные"
    case undone = "Не завершенные"
}
