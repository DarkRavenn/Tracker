//
//  ChooseCreateTrackerViewController.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 27.10.2024.
//

import UIKit

final class ChooseCreateTrackerViewController: UIViewController {
    
    private let onAddTracker: (Tracker, String) -> Void
    
    init(onAddTracker: @escaping (Tracker, String) -> Void) {
        self.onAddTracker = onAddTracker
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        self.title = "Создание трекера"
        
        let button1 = getButton("Привычка")
        button1.addTarget(self, action: #selector(opencCreateTrackerWithSchedule), for: .touchUpInside)
        let button2 = getButton("Нерегулярное событие")
        button2.addTarget(self, action: #selector(opencCreateTrackerWOSchedule), for: .touchUpInside)
        
        view.addSubview(button1)
        view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            button1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            button1.heightAnchor.constraint(equalToConstant: 60),
            
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 16),
            button2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            button2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            button2.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func getButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .ypBlack
        button.setTitleColor(.ypWhite, for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    @objc private func opencCreateTrackerWithSchedule() {
        navigationController?.pushViewController(CreateTrackerViewController(onCreateTracker: self.onAddTracker, isRegular: true), animated: true)
    }
    
    @objc private func opencCreateTrackerWOSchedule() {
        navigationController?.pushViewController(CreateTrackerViewController(onCreateTracker: self.onAddTracker, isRegular: false), animated: true)
    }
}