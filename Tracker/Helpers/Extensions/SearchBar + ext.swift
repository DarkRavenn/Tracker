//
//  SearchBar + ext.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 16.10.2024.
//

import UIKit

extension UISearchBar {
    func placeholderIconColor(color: UIColor) {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : color])
        }
    }
    
    func placeholderTextColor(color: UIColor) {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = color
            }
        }
    }
}
