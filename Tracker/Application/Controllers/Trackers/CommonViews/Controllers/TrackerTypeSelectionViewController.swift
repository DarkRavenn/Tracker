//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Aleksandr Dugaev on 27.10.2024.
//

import UIKit

struct tableOption {
    let title: String
    var subtitle: String = ""
    let vc: UIViewController.Type
}

// экран создания нового трекера
final class TrackerTypeSelectionViewController: UIViewController {
    
    private let onCreateTracker: (Tracker, String) -> Void
    private let isRegular: Bool

    private var trackerName: String = ""
    private var category: TrackerCategory = TrackerCategory(title: "Новые", trackers: [])
    private var schedule: [Weekday] = []
    private var trackerEmoji: String = "⭐️"
    private var trackerColor: UIColor = .ypColorSelection13
    private var tableOptions: [tableOption] = []
    
    init(onCreateTracker: @escaping (Tracker, String) -> Void, isRegular: Bool) {
        self.onCreateTracker = onCreateTracker
        self.isRegular = isRegular
        
        self.tableOptions.append(tableOption(title: "Категория", subtitle: category.title, vc: ChooseCreateTrackerViewController.self))
        if isRegular {
            // если событие регулярное (привычка), то добавляем в меню пункт "Расписание"
            self.tableOptions.append(tableOption(title: "Расписание", vc: SetScheduleViewController.self))
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
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
    
    private lazy var nameTextField: UITextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Введите название трекера"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .ypBackground
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var longNameWarningLabel: UILabel = {
        let label = UILabel()
        label.text = "Ограничение 38 символов"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = .ypRed
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .ypWhite
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var createButtonView: UIButton = {
        let button = CustomButton(type: .custom)
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.ypWhite, for: .normal)
        button.layer.cornerRadius = 16
        button.setBackgroundColor(.ypBlack, for: .normal)
        button.setBackgroundColor(.ypGray, for: .disabled)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButtonView: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.ypRed, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.ypRed.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.title = "Новая привычка"
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .ypWhite
        
        // название трекера
        let nameStackView = UIStackView(arrangedSubviews: [nameTextField, longNameWarningLabel])
        nameStackView.axis = .vertical
        nameStackView.spacing = 8
        mainStackView.addArrangedSubview(nameStackView)
        
        // выбор категории и расписания
        mainStackView.addArrangedSubview(tableView)
        
        // кнопки снизу
        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButtonView, createButtonView])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 8
        buttonsStackView.distribution = .fillEqually
        mainStackView.addArrangedSubview(buttonsStackView)
        
        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 75),
            tableView.heightAnchor.constraint(equalToConstant: self.isRegular ? 151 : 76),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func onUpdateSchedule(_ schedule: [Weekday]) {
        self.schedule = schedule
        if schedule.count == 7 {
            self.tableOptions[1].subtitle = "Каждый день"
        } else {
            self.tableOptions[1].subtitle = schedule.map { item in
                switch item {
                case .monday: return "Пн"
                case .tuesday: return "Вт"
                case .wednesday: return "Ср"
                case .thursday: return "Чт"
                case .friday: return "Пт"
                case .saturday: return "Сб"
                case .sunday: return "Вс"
                }
            }.joined(separator: ", ")
        }
        self.tableView.reloadData()
        self.updateCreateButtonState()
    }
    
    // блокирует/разблокирует кнопку "Создать"
    private func updateCreateButtonState() {
        createButtonView.isEnabled = !self.trackerName.isEmpty && (!self.schedule.isEmpty || !isRegular)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // проверка на длину поля с именем
        if let length = textField.text?.count {
            longNameWarningLabel.isHidden = length <= 38
            view.layoutIfNeeded()
        }
        
        if longNameWarningLabel.isHidden {
            self.trackerName = textField.text ?? ""
        } else {
            self.trackerName = ""
        }
        
        self.updateCreateButtonState()
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func createButtonTapped() {
        self.onCreateTracker(
            Tracker(id: UUID(), name: self.trackerName, color: self.trackerColor, emoji: self.trackerEmoji, schedule: self.schedule),
            self.category.title
        )
        
        // возвращаемся на экран со списком трекеров
        if let viewControllers = navigationController?.viewControllers {
            for vc in viewControllers {
                vc.dismiss(animated: true)
            }
        }
    }
}

// TableViewDataSource Protocol
extension TrackerTypeSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.textLabel?.text = self.tableOptions[indexPath.row].title
        cell.detailTextLabel?.text = self.tableOptions[indexPath.row].subtitle
        return cell
    }
}

// TableViewDelegate Protocol
extension TrackerTypeSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = self.tableOptions[indexPath.row].title
        if selected == "Категория" {
            // переход в выбор категории
        } else if selected == "Расписание" {
            // переход в выбор расписания
            navigationController?.pushViewController(
                SetScheduleViewController(schedule: self.schedule, updateSchedule: self.onUpdateSchedule),
                animated: true
            )
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}


