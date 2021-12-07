//
//  MainView.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

class HabitsView: UIView {
    
    lazy var habitsStore: HabitsStore = .shared
    
    var habits: [Habit] {
        habitsStore.habits
    }
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.identifier)
        tableView.register(ProgressTableViewCell.self, forCellReuseIdentifier: ProgressTableViewCell.identifier)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appLightGray
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func reloadTableViewData() {
        tableView.reloadData()
    }
    
}

extension HabitsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return habits.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgressTableViewCell.identifier) as? ProgressTableViewCell else {
                fatalError()
            }
            
            cell.progress = habitsStore.todayProgress
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier) as? HabitTableViewCell else {
                fatalError()
            }
            
            cell.set(habit: habits[indexPath.row])
            
            cell.checkButton.addTarget(self, action: #selector(reloadTableViewData), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 60 + ProgressTableViewCell.spacing + 6
        } else {
            return 130 + HabitTableViewCell.spacing
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 60 + ProgressTableViewCell.spacing + 6
        } else {
            return 130 + HabitTableViewCell.spacing
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
   
}
