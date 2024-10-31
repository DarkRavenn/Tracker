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
    }
    
    enum Strings {
        enum TabBar {
            static var trackers = "Трекеры"
            static var statistic = "Статистика"
        }
    }
    
    enum Images {
        enum TabBar {
            static var trackers = UIImage(named: "trackers-tab-bar-icon")
            static var statistic = UIImage(named: "statistics-tab-bar-icon")
        }
    }
}
