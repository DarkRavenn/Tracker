//
//  UserProperty.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 09.02.2025.
//

import Foundation

class UserProperty {
    static let shared = UserProperty()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    var hasSeenOnboarding: Bool {
        get {
            return defaults.bool(forKey: Resources.Strings.UserDefaults.isOnboardingViewed)
        }
        set {
            defaults.set(newValue, forKey: Resources.Strings.UserDefaults.isOnboardingViewed)
        }
    }
}
