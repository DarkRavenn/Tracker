//
//  TrackerController.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 10.10.2024.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    private let datePicker = TrackerDatePicker()
    private var TrackerDatePickerObserver: NSObjectProtocol?
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        button.tintColor = UIColor.ypBlack
        return button
    }()
    
    private lazy var searchBarController: UISearchController = {
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchBar.placeholder = Resources.Strings.NavBar.searchBarPlaceholder
        searchBarController.searchBar.placeholderIconColor(color: Resources.Colors.searchBarPlaceholderColor)
        searchBarController.searchBar.placeholderTextColor(color: Resources.Colors.searchBarPlaceholderColor)
        return searchBarController
    }()
    
    private lazy var emptyTrackersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.Trackers.emptyTrackersPlaceholder
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emptyTrackersTextLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.Trackers.emptyTrackersTextLabel
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .ypBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Resources.Strings.NavBar.navigationHeader
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = addButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchBarController
        
        view.addSubview(emptyTrackersImageView)
        view.addSubview(emptyTrackersTextLabel)
        
        NSLayoutConstraint.activate([
            emptyTrackersImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyTrackersImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 35),
            emptyTrackersImageView.widthAnchor.constraint(equalToConstant: 80),
            emptyTrackersImageView.heightAnchor.constraint(equalToConstant: 80),
            
            emptyTrackersTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyTrackersTextLabel.topAnchor.constraint(equalTo: emptyTrackersImageView.bottomAnchor, constant: 8),
        ])
        
        TrackerDatePickerObserver = NotificationCenter.default
            .addObserver(
                forName: TrackerDatePicker.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.dateChanged()
            }
    }
    
    // обновление текущей даты
    private func dateChanged() {
        currentDate = datePicker.datePicker.date
    }

    // добавление нового трекера
    @objc private func addTapped() {
    }
}
