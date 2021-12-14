//
//  MainViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var habitViewController: HabitViewController = HabitViewController()
    lazy var habitDetailsViewController: HabitDetailsViewController = HabitDetailsViewController()
    
    lazy var habitsView: HabitsView = HabitsView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Привычки"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureNavigationBar()
        
        habitsView.delegate = self
        habitDetailsViewController.habitViewController = habitViewController
        habitViewController.saveCompletion = { [weak self] in
            guard let self = self else { return }
            if let toStart = $0, toStart {
                self.navigationController?.popViewController(animated: true)
            }
            self.habitsView.collectionView.reloadData()
            self.habitsView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    private func configureLayout() {
        view.addSubview(habitsView)
        habitsView.putIntoSafeArea(view: view)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Сегодня"
    }
    
    private func openHabitView(with habit: Habit? = nil) {
        let navVC = UINavigationController(rootViewController: habitViewController)
        
        if let habit = habit {
            habitViewController.isEdit = true
            habitViewController.habit = habit
        } else {
            habitViewController.isEdit = false
            habitViewController.habit = nil
        }
        
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func openHabitDetails(with habit: Habit, index: Int) {
        habitDetailsViewController.habit = habit
        habitDetailsViewController.habitIndex = index
        habitDetailsViewController.tableView.reloadData()
        habitDetailsViewController.navigationItem.titleView = createNavHeader(with: habit.name)
        
        navigationController?.pushViewController(habitDetailsViewController, animated: true)
    }
    
    private func createNavHeader(with title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.text = title
        
        return titleLabel
    }
    
    @objc private func addHabit() {
        openHabitView()
    }
    
}

extension HabitsViewController: HabitsViewDelegate {
    
    func onHabitCellTap(_ habit: Habit, index: Int) {
        openHabitDetails(with: habit, index: index)
    }
    
}
