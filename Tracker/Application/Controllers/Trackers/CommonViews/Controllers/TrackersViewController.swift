//
//  TrackerController.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 10.10.2024.
//

import UIKit

// экран с коллекцией трекеров
final class TrackersViewController: UIViewController {
    private let dataProvider = DataProvider()
    private let datePicker = CustomDatePicker()
    private var TrackerDatePickerObserver: NSObjectProtocol?
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        button.tintColor = UIColor.ypBlack
        return button
    }()
    
    private lazy var searchBarController: UISearchController = {
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchBar.placeholder = Resources.Strings.NavBar.searchBarPlaceholder
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.placeholderIconColor(color: Resources.Colors.searchBarPlaceholderColor)
        searchBarController.searchBar.placeholderTextColor(color: Resources.Colors.searchBarPlaceholderColor)
        return searchBarController
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var trackersCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(TrackerCollectionCell.self, forCellWithReuseIdentifier: TrackerCollectionCell.identifier)
        collection.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .ypWhite
        collection.showsVerticalScrollIndicator = false
        return collection
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
    private var categories: [TrackerCategory] = []
    private var categoriesFilteredBySearch: [TrackerCategory] = []
    private var categoriesFilteredByDate: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []
    private let collectionParams = GeometricParams(cellCount: 2, leftInset: 0, rightInset: 0, cellSpacing: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        navigationItem.title = Resources.Strings.NavBar.navigationHeader
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = addButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.searchController = searchBarController
        
        mainStackView.addArrangedSubview(trackersCollection)
        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            trackersCollection.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
        ])
        
        TrackerDatePickerObserver = NotificationCenter.default
            .addObserver(
                forName: CustomDatePicker.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.dateChanged()
            }
        try? dataProvider.tracker.fetchTracker()
    }
    
    // фильтрует трекеры по выбранной дате
    private func filterTrackersByCurrentDate() {
        // получаем день недели выбранной даты
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let weekday = calendar.component(.weekday, from: currentDate)
        let weekdayString = dateFormatter.weekdaySymbols[weekday - 1].capitalized
        
        print("weekdayString: ", weekdayString)
        
        if let currentWeekday = Weekday(rawValue: weekdayString) {
            categoriesFilteredByDate = categories.compactMap { category in
                let filteredTrackers = category.trackers.filter { tracker in
                    if tracker.schedule.contains(currentWeekday) {
                        // регулярное событие, выпадающее на выбранную дату
                        return true
                    } else if tracker.schedule.isEmpty && !isTrackerEverBeenDone(tracker.id) {
                        // не выполненное нерегулярное событие
                        return true
                    } else if tracker.schedule.isEmpty && isTrackerDoneOnCurrentDate(tracker.id) {
                        // выполненное в выбранную дату нерегулярное событие
                        return true
                    }
                    return false
                }
                if filteredTrackers.isEmpty {
                    return nil
                } else {
                    return TrackerCategory(title: category.title, trackers: filteredTrackers)
                }
            }
            categoriesFilteredBySearch = categoriesFilteredByDate
            trackersCollection.reloadData()
        }
    }
    
    // проверяет, есть ли вообще трекеры
    private func isNoTrackers() -> Bool {
        let trackersCount = categoriesFilteredBySearch.reduce(0) { $0 + $1.trackers.count }
        return trackersCount == 0
    }
    
    // проверяет, отмечен ли трекер как выполненный в текущую дату
    private func isTrackerDoneOnCurrentDate(_ trackerID: UUID) -> Bool {
        return completedTrackers.contains(where: { $0.trackerID == trackerID && Calendar.current.isDate($0.date, inSameDayAs: currentDate) })
    }
    
    // проверяет, отмечен ли трекер как выполненный хоть в какуб-нибудь дату
    private func isTrackerEverBeenDone(_ trackerID: UUID) -> Bool {
        return completedTrackers.contains(where: { $0.trackerID == trackerID })
    }
    
    // возвращает строку с кол-вом дней, в который трекер выполнялся
    private func getTrackerDaysLabelText(_ indexPath: IndexPath) -> String {
        let tracker = categoriesFilteredBySearch[indexPath.section].trackers[indexPath.row]
        
        // для нерегулярных событий нет смысла считать дни
        if tracker.schedule.isEmpty {
            return ""
        }
        
        let days = completedTrackers.filter({$0.trackerID == tracker.id}).count
        
        if days % 10 == 1 && days % 100 != 11 {
            return "\(days) день"
        } else if (days % 10 == 2 || days % 10 == 3 || days % 10 == 4) && (days % 100 < 10 || days % 100 > 20) {
            return "\(days) дня"
        } else {
            return "\(days) дней"
        }
    }
    
    // Добавляет новый трекер в коллекцию
    private func addTracker(_ tracker: Tracker, categoryName: String) {
        //  проверяем, есть ли категория в списке
        if categories.contains(where: { $0.title == categoryName }) {
            categories = categories.map { $0.title == categoryName ? TrackerCategory(title: $0.title, trackers: $0.trackers + [tracker]) : $0 }
        } else {
            categories.insert(TrackerCategory(title: categoryName, trackers: [tracker]), at: 0)
        }
        searchBarController.searchBar.text = ""
        filterTrackersByCurrentDate()
        
        print("categories: ", categories)
    }
    
    // отмечает трекер как выполненный в текущую дату
    @objc private func updateTrackersDoneStatus(_ trackerID: UUID, _ isAdding: Bool) {
        if isAdding {
            completedTrackers.append(TrackerRecord(trackerID: trackerID, date: currentDate))
        } else {
            completedTrackers = completedTrackers.filter { $0.trackerID != trackerID || !Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
        }
        
        trackersCollection.reloadData()
    }
    
    // обновление текущей даты
    private func dateChanged() {
        currentDate = datePicker.datePicker.date
        filterTrackersByCurrentDate()
    }
    
    // добавление нового трекера
    @objc private func addTapped() {
        present(UINavigationController(rootViewController: ChooseCreateTrackerViewController(onAddTracker: addTracker)), animated: true, completion: nil)
    }
}

// UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // количество категорий
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (categoriesFilteredBySearch.count == 0) {
            if (categories.count == 0) {
                setBGViewToCollection(trackersCollection, imageName: "trackers-placeholder", text: "Что будем отслеживать?")
            } else {
                setBGViewToCollection(trackersCollection, imageName: "no-trackers-found", text: "Ничего не найдено")
            }
        } else {
            trackersCollection.backgroundView = nil
        }
        
        return categoriesFilteredBySearch.count
    }
    
    // количество ячеек в каждой категории
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesFilteredBySearch[section].trackers.count
    }
    
    // настройка ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCollectionCell.identifier, for: indexPath) as! TrackerCollectionCell
        let tracker = categoriesFilteredBySearch[indexPath.section].trackers[indexPath.row]
        cell.textLabel.text = tracker.name
        cell.infoLabel.text = getTrackerDaysLabelText(indexPath)
        cell.cardView.backgroundColor = tracker.color
        cell.onUpdateTrackersDoneStatus = self.updateTrackersDoneStatus
        cell.emojiLabel.text = tracker.emoji
        cell.addButton.accessibilityValue = tracker.id.uuidString
        
        if isTrackerDoneOnCurrentDate(tracker.id) {
            cell.addButton.backgroundColor = tracker.color.withAlphaComponent(0.5)
            cell.addButton.isSelected = true
        } else {
            cell.addButton.backgroundColor = tracker.color
            cell.addButton.isSelected = false
        }
        
        // скрываем "+" для будущих дат
        cell.addButton.isHidden = Calendar.current.compare(Date(), to: currentDate, toGranularity: .day) == .orderedAscending
        
        
        return cell
    }
    
    // размеры ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - collectionParams.paddingWidth
        let cellWidth =  availableWidth / CGFloat(collectionParams.cellCount)
        return CGSize(width: cellWidth, height: 140)
    }
    
    // вертикальный отступ ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionParams.cellSpacing
    }
    
    // горизонтальные отступ ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        collectionParams.cellSpacing
    }
    
    // отступ от краёв
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: collectionParams.leftInset, bottom: 24, right: collectionParams.rightInset)
    }
    
    // настройка хедера
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        default:
            id = ""
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! SupplementaryView
        // текст заголовка
        view.titleLabel.text = categoriesFilteredBySearch[indexPath.section].title
        view.titleLabel.font = .systemFont(ofSize: 19, weight: .bold)
        return view
    }
    
    //     размер хедера
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

// для управления SearchBar'ом
extension TrackersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            categoriesFilteredBySearch = categoriesFilteredByDate
            trackersCollection.reloadData()
            return
        }
        
        categoriesFilteredBySearch = categoriesFilteredByDate.compactMap { category in
            let filteredTrackers = category.trackers.filter { tracker in
                tracker.name.lowercased().contains(searchText.lowercased())
            }
            if filteredTrackers.isEmpty {
                return nil
            } else {
                return TrackerCategory(title: category.title, trackers: filteredTrackers)
            }
        }
        
        trackersCollection.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        categoriesFilteredBySearch = categoriesFilteredByDate
        trackersCollection.reloadData()
    }
}

// для настройки плейсхолдеров коллекции трекеров
extension TrackersViewController {
    
    func setBGViewToCollection(_ collectionView: UICollectionView, imageName: String, text: String) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .ypBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
        ])
        
        collectionView.backgroundView = view;
    }
}
