//
//  AppDelegate.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 26.09.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        if UserProperty.shared.hasSeenOnboarding {
            window?.rootViewController = TabBarViewController()
        } else {
            window?.rootViewController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal) as UIPageViewController
        }

        window?.makeKeyAndVisible()
        
        AnalyticsService.activate()

        return true
    }
}

