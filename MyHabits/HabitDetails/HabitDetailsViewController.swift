//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 10.12.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    private let tableViewCellIdentifier: String = "table-view-cell"
    
    var habitViewController: HabitViewController?
    
    let habitsStore = HabitsStore.shared
    
    var habit: Habit?
    var habitIndex: Int?
    
    var trackDates: [Date] {
        habitsStore.dates.reversed()
    }
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .grouped)
        
        return tableView
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "RU")
        
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        configureTableView()
        configureLayout()
        configureNavigationBar()
        configureStyle()
        
        let oldSaveCompletion = habitViewController?.saveCompletion
        habitViewController?.saveCompletion = { Bool in
            oldSaveCompletion?(false)
            if let habitIndex = self.habitIndex {
                self.habit = self.habitsStore.habits[habitIndex]
                (self.navigationItem.titleView as! UILabel).text = self.habit?.name
                self.habitsStore.save()
            }
        }
    }
    
    private func configureStyle() {
        view.backgroundColor = .white
    }
    
    private func configureLayout() {
        view.addSubview(tableView)
        tableView.putIntoSafeArea(view: view)
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        navigationController?.navigationBar.topItem?.backButtonTitle = "Отменить"
    }
    
    @objc func editHabit() {
        if let habitViewController = habitViewController {
            let navVC = UINavigationController(rootViewController: habitViewController)

            if let habit = habit, let habitIndex = habitIndex {
                habitViewController.isEdit = true
                habitViewController.habit = habit
                habitViewController.habitIndex = habitIndex
            }

            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackDates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = getDateString(from: trackDates[indexPath.row])
        if let habit = habit, habitsStore.habit(habit, isTrackedIn: trackDates[indexPath.row]) {
            cell.accessoryView = UIImageView(image: .init(systemName: "checkmark"))
        }
        
        return cell
    }
    
    private func getDateString(from date: Date) -> String {
        var dateString = dateFormatter.string(from: date)
        let now = Date.now
        
        if dateString == dateFormatter.string(from: now) {
            dateString = "Сегодня"
        } else if dateString == dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: now)!) {
            dateString = "Вчера"
        } else if dateString == dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -2, to: now)!) {
            dateString = "Позавчера"
        }
        
        return dateString
    }
    
}
