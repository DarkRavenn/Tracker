//
//  OnboardingPageFactory.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 08.02.2025.
//

import UIKit

final class OnboardingPageFactory {
    static func createOnboardingPage(bodyText: String, image: UIImage, buttonText: String, action: @escaping () -> Void) -> UIViewController {
        
        // Создаем контейнерный контроллер
        let customViewController = UIViewController()
        customViewController.view.backgroundColor = .white
        
        // UILabel
        let label = UILabel()
        label.textColor = .black.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = bodyText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // UIImageView
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // UIButton
        let button: UIButton
        
        if #available(iOS 14.0, *) {
            // Используется для iOS 14.0 и новее
            button = UIButton(primaryAction: UIAction { _ in
                action() // Выполняем переданное замыкание
            })
        } else {
            // Для старых версий iOS
            button = UIButton(type: .system)
            button.addTarget(closureWrapper(forAction: action), action: #selector(ClosureWrapper.executeAction), for: .touchUpInside)
        }
        button.setTitle(buttonText, for: .normal)
        button.backgroundColor = .black.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        button.layer.cornerRadius = 16
        button.setTitleColor(.white.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)),
                             for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем элементы в контейнер
        customViewController.view.addSubview(imageView)
        customViewController.view.addSubview(button)
        customViewController.view.addSubview(label)
        
        // Констрейнты
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customViewController.view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: customViewController.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: customViewController.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: customViewController.view.bottomAnchor),
            
            button.bottomAnchor.constraint(equalTo: customViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: customViewController.view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: customViewController.view.trailingAnchor, constant: -20),
            
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -160),
            label.leadingAnchor.constraint(equalTo: customViewController.view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: customViewController.view.trailingAnchor, constant: -16),
        ])
        
        return customViewController
    }
    
    // Обертка для замыкания
    private static func closureWrapper(forAction action: @escaping () -> Void) -> ClosureWrapper {
        return ClosureWrapper(action: action)
    }
}

class ClosureWrapper: NSObject {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    @objc func executeAction() {
        action() // Выполняем переданное замыкание
    }
}
