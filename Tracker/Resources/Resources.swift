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
        static var dateFormat = NSLocalizedString("common.dateFormat", comment: "dd.MM.yy")
        static var datePickerLocale = NSLocalizedString("common.datePickerLocale", comment: "ru_RU")
    }
    
    enum Strings {
        
        enum TabBar {
            static var trackers = NSLocalizedString("tabBar.trackers.title", comment: "Трекеры")
            static var statistic = NSLocalizedString("tabBar.statistics.title", comment: "Статистика")
        }
        
        enum NavBar {
            static var searchBarPlaceholder = NSLocalizedString("trackers.searchBar.placeholder", comment: "Поиск")
            static var navigationHeader = NSLocalizedString("trackers.title", comment: "Трекеры")
        }
        
        enum Trackers {
            static var emptyTrackers = NSLocalizedString("trackers.emptyTrackers", comment: "Что будем отслеживать?")
            static var noTrackersFound = NSLocalizedString("trackers.noTrackersFound", comment: "Ничего не найдено")
            static var daysTracked = NSLocalizedString("daysTracked", comment: "Number of days tracked")
            
            enum ContextMenu {
                static var pin = NSLocalizedString("trackers.contextMenu.pin", comment: "Открепить")
                static var edit = NSLocalizedString("trackers.contextMenu.edit", comment: "Редактировать")
                static var unpin = NSLocalizedString("trackers.contextMenu.unpin", comment: "Закрепить")
                static var remove = NSLocalizedString("trackers.contextMenu.remove", comment: "Удалить")
                
                enum RemoveModal {
                    static var title = NSLocalizedString("trackers.contextMenu.remove.modal.title", comment: "Уверены, что хотите удалить трекер?")
                    static var ok = NSLocalizedString("trackers.contextMenu.remove.modal.ok", comment: "Удалить")
                    static var cancel = NSLocalizedString("trackers.contextMenu.remove.modal.cancel", comment: "Отменить")
                }
            }
        }
//        Resources.Strings.Trackers.ContextMenu
        
        enum TrackerTypeSelection {
            static var title = NSLocalizedString("trackerTypeSelection.title", comment: "Создание трекера")
            static var regular = NSLocalizedString("trackerTypeSelection.regular", comment: "Привычка")
            static var irregular = NSLocalizedString("trackerTypeSelection.irregular", comment: "Нерегулярное событие")
        }
        
        enum TrackerCreation {
            static var emoji = NSLocalizedString("trackerCreation.emoji", comment: "Emoji")
            static var color = NSLocalizedString("trackerCreation.color", comment: "Цвет")
            static var category = NSLocalizedString("trackerCreation.category", comment: "Категория")
            static var schedule = NSLocalizedString("trackerCreation.schedule", comment: "Расписание")
            static var saveButton = NSLocalizedString("trackerCreation.saveButton", comment: "Создать")
            static var cancelButton = NSLocalizedString("trackerCreation.cancelButton", comment: "Отменить")
            static var title = NSLocalizedString("trackerCreation.title", comment: "Новая привычка")
            
            enum NameTextField {
                static var placeholder = NSLocalizedString("trackerCreation.nameTextField.placeholder", comment: "Введите название трекера")
                static var maxLen = NSLocalizedString("trackerCreation.nameTextField.maxLen", comment: "Ограничение 38 символов")
            }
            
            enum Schedule {
                static var everyDay = NSLocalizedString("trackerCreation.schedule.everyDay", comment: "Каждый день")
            }
            
            enum Weekdays {
                static var mon = NSLocalizedString("trackerCreation.weekdays.mon", comment: "Пн")
                static var tue = NSLocalizedString("trackerCreation.weekdays.tue", comment: "Вт")
                static var wed = NSLocalizedString("trackerCreation.weekdays.wed", comment: "Ср")
                static var thu = NSLocalizedString("trackerCreation.weekdays.thu", comment: "Чт")
                static var fri = NSLocalizedString("trackerCreation.weekdays.fri", comment: "Пт")
                static var sat = NSLocalizedString("trackerCreation.weekdays.sat", comment: "Сб")
                static var sun = NSLocalizedString("trackerCreation.weekdays.sun", comment: "Вс")
            }
        }
        
        enum Category {
            enum NewCategoryButton {
                static var text = NSLocalizedString("category.newCategoryButton.text", comment: "Добавить категорию")
            }
            
            enum Table {
                static var placeholer = NSLocalizedString("category.table.placeholer", comment: "Привычки и события можно объединить по смыслу")
            }
        }
        
        enum NewCategory {
            static var title = NSLocalizedString("newCategory.title", comment: "Новая категория")
            
            enum nameTextField {
                static var placeholder = NSLocalizedString("newCategory.nameTextField.placeholder", comment: "Введите название категории")
                static var maxLen = NSLocalizedString("newCategory.nameTextField.maxLen", comment: "Ограничение 24 символа")
            }
            
            enum doneButton {
                static var text = NSLocalizedString("newCategory.doneButton.text", comment: "Готово")
            }
        }
        
        enum Schedule {
            static var title = NSLocalizedString("schedule.title", comment: NSLocalizedString("", comment: "Расписание"))
            
            enum DoneBytton {
                static var title = NSLocalizedString("schedule.doneButton", comment: "Готово")
            }
            
            enum Weekdays {
                static var mon = NSLocalizedString("schedule.weekdays.mon", comment: "Понедельник")
                static var tue = NSLocalizedString("schedule.weekdays.tue", comment: "Вторник")
                static var wed = NSLocalizedString("schedule.weekdays.wed", comment: "Среда")
                static var thu = NSLocalizedString("schedule.weekdays.thu", comment: "Четверг")
                static var fri = NSLocalizedString("schedule.weekdays.fri", comment: "Пятница")
                static var sat = NSLocalizedString("schedule.weekdays.sat", comment: "Суббота")
                static var sun = NSLocalizedString("schedule.weekdays.sun", comment: "Воскресенье")
            }
        }
        
        enum Onboarding {
            enum BodyText {
                static var pageOne = NSLocalizedString("onboarding.page1.text", comment: "Отслеживайте только то, что хотите")
                static var pageTwo = NSLocalizedString("onboarding.page2.text", comment: "Даже если это не литры воды и йога")
            }
            
            enum ButtonText {
                static var pageOneOfPageTwo = NSLocalizedString("onboarding.page1.text", comment: "Вот это технологии!")
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
