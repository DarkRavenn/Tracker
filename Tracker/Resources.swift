//
//  Resources.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 31.10.2024.
//

import UIKit

enum Resources {
    enum Colors {
        static var separator = UIColor.ypTabBarSeparator
        static var viewControllerBackground = UIColor.ypWhite
        static var searchBarPlaceholderColor = UIColor.ypSearchBarPlaceholder
    }
    
    enum Strings {
        enum TabBar {
            static var trackers = "Трекеры"
            static var statistic = "Статистика"
        }
        
        enum NavBar {
            static var datePickerLocale = "ru_RU"
            static var searchBarPlaceholder = "Поиск"
            static var navigationHeader = "Трекеры"
        }
        
        enum Trackers {
            static var emptyTrackersTextLabel = "Что будем отслеживать?"
        }
    }
    
    enum Images {
        enum TabBar {
            static var trackers = UIImage(named: "trackers-tab-bar-icon")
            static var statistic = UIImage(named: "statistics-tab-bar-icon")
        }
        
        enum Trackers {
            static var emptyTrackersPlaceholder = UIImage(named: "trackers-placeholder")
        }
    }
}
