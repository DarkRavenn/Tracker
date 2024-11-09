//
//  UIViewController + ext.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 06.11.2024.
//

import UIKit

// Расширение скрывающее клавиатуру при тапе за ее пределами
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        navigationItem.searchController?.searchBar.endEditing(true)
    }
}
