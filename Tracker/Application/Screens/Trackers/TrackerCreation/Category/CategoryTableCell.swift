//
//  CategoryTableCell.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 09.02.2025.
//

import UIKit

final class CategoryTableCell: UITableViewCell {
    
    private var categoryText: String?
    private var isSelectedCategory: Bool = false
    
    private var accessoryViewLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .ypBlue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .ypBackground
        
        layer.masksToBounds = true
        layer.cornerRadius = 16
        
        translatesAutoresizingMaskIntoConstraints = false
        
        selectionStyle = .none
        
        contentView.addSubview(accessoryViewLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Скругляем углы ячейкам в зависимости от их позиции в таблице
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else { return }
        
        let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if numberOfRows == 1 {
            // Если строка только одна (скругляем полностью)
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
        } else if indexPath.row == 0 {
            // Первая строка (скругляем сверху)
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == numberOfRows - 1 {
            // Последняя строка (скругляем снизу)
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
        } else {
            // Строки в середине (без скруглений)
            layer.maskedCorners = []
        }
    }
    
    func updateCategoryText(_ text: String) {
        categoryText = text
        textLabel?.text = text
    }
    
    func updateCategorySelection(isSelected: Bool) {
        isSelectedCategory = isSelected
        accessoryView = isSelectedCategory ? UIImageView(image: UIImage(systemName: "checkmark")) : nil
    }
    
    func updateSeparatorInset() {
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
