//
//  TrackerDataPicker.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 27.10.2024.
//

import UIKit

final class CustomDatePicker: BaseView {
    
    let datePicker = UIDatePicker()
    static let didChangeNotification = Notification.Name(rawValue: "CustomDatePickerDidChange")
    
    private let formatter = DateFormatter()
    private let datePickerText = UILabel()
}

extension CustomDatePicker {
    
    override func addViews() {
        super.addViews()

        addView(datePicker)
        addView(datePickerText)
    }
                
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: topAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor),
            datePickerText.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePickerText.topAnchor.constraint(equalTo: topAnchor),
            datePickerText.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePickerText.bottomAnchor.constraint(equalTo: bottomAnchor),
            datePickerText.widthAnchor.constraint(equalToConstant: 77),
            datePickerText.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    override func configure() {
        super.configure()
        
        formatter.dateFormat = Resources.Common.dateFormat
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: Resources.Common.datePickerLocale)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        datePickerText.text = formatter.string(from: Date())
        datePickerText.textColor = .black
        datePickerText.textAlignment = .center
        datePickerText.backgroundColor = Resources.Colors.dataPickerBackgroundColor
        datePickerText.layer.cornerRadius = 8
        datePickerText.clipsToBounds = true
        datePickerText.font = .systemFont(ofSize: 17, weight: .regular)
    }

    @objc func dateChanged() {
        datePickerText.text = formatter.string(from: datePicker.date)
        
        NotificationCenter.default
            .post(name: CustomDatePicker.didChangeNotification,
                  object: self,
                  userInfo: ["Date": datePicker.date])
    }
}
