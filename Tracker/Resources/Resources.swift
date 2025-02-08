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
        static var dataPickerBackgroundColor = UIColor.ypDataPickerBackground
    }
    
    enum Common {
        static var dateFormat = "dd.MM.yy"
        static var datePickerLocale = "ru_RU"
    }
    
    enum Strings {
        
        enum TabBar {
            static var trackers = "Трекеры"
            static var statistic = "Статистика"
        }
        
        enum NavBar {
            static var searchBarPlaceholder = "Поиск"
            static var navigationHeader = "Трекеры"
        }
        
        enum Trackers {
            static var trackersPlaceholder = "Что будем отслеживать?"
            static var noTrackersFound = "Ничего не найдено"
        }
        
        enum Onboarding {
            enum BodyText {
                static var pageOne = "Отслеживайте только то, что хотите"
                static var pageTwo = "Даже если это не литры воды и йога"
            }
            
            enum ButtonText {
                static var pageOneOfPageTwo = "Вот это технологии!"
            }
        }
        
        enum UserDefaults {
            static var isOnboardingViewed = "isOnboardingViewed"
        }
    }
    
    enum Images {
        enum TabBar {
            static var trackers = UIImage(named: "trackers-tab-bar-icon")
            static var statistic = UIImage(named: "statistics-tab-bar-icon")
        }
        
        enum Trackers {
            static var trackersPlaceholder = UIImage(named: "trackers-placeholder")!
            static var noTrackersFound = UIImage(named: "no-trackers-found")!
        }
        
        enum Onboarding {
            static var pageOne = UIImage(named: "onboarding_page_1")!
            static var pageTwo = UIImage(named: "onboarding_page_2")!
        }
    }
}
