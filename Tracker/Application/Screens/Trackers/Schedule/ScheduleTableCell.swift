//
//  ScheduleTableCell.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 27.10.2024.
//

import UIKit

final class ScheduleTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .ypBackground
        
        layer.masksToBounds = true
        layer.cornerRadius = 16
        
        translatesAutoresizingMaskIntoConstraints = false
        
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Скругляем углы ячейкам в зависимости от их позиции в таблице
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else { return }
        
        if indexPath.row == 0 {
            // Первая строка (скругляем сверху)
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            // Последняя строка (скругляем снизу)
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
        } else {
            // Строки в середине (без скруглений)
            layer.maskedCorners = []
        }
    }
}



