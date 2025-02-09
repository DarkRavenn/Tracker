//
//  TabBarController.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 10.10.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
        
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               tabBar.layer.borderColor = Resources.Colors.separator.cgColor
           }
       }
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.viewControllerBackground
        
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        
        // вкладка Трекеры
        let trackerViewController = UINavigationController(rootViewController: TrackersViewController())
        trackerViewController.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.trackers,
            image: Resources.Images.TabBar.trackers,
            selectedImage: nil
        )
        
        // вкладка Статистика
        let statisticsViewController = StatisticsViewController()
        statisticsViewController.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.statistic,
            image: Resources.Images.TabBar.statistic,
            selectedImage: nil
        )
        
        viewControllers = [trackerViewController, statisticsViewController]
    }
}
