//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 10.12.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        configureTableView()
        configureLayout()
        configureNavigationBar()
        configureStyle()
        
        let oldSaveCompletion = habitViewController?.saveCompletion
        habitViewController?.saveCompletion = {
            if let toStart = $0 {
                oldSaveCompletion?(toStart)
                if let habitIndex = self.habitIndex, !toStart {
                    self.habit = self.habitsStore.habits[habitIndex]
                    (self.navigationItem.titleView as! UILabel).text = self.habit?.name
                    self.habitsStore.save()
                }
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
        tableView.register(TrackDateTableViewCell.self, forCellReuseIdentifier: TrackDateTableViewCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackDateTableViewCell.identifier, for: indexPath) as? TrackDateTableViewCell else {
            fatalError()
        }
        
        if let habit = habit {
            cell.set(date: trackDates[indexPath.row], habit: habit)
        }
        
        return cell
    }
    
}
