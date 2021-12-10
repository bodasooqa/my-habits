//
//  MainViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var habitViewController: HabitViewController = HabitViewController()
    
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
        habitViewController.saveCompletion = { [weak self] in
            guard let self = self else { return }
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
        present(navVC, animated: true, completion: nil)
    }
    
    @objc private func addHabit() {
        openHabitView()
    }
    
}

extension HabitsViewController: HabitsViewDelegate {
    
    func onHabitCellTap(_ habit: Habit) {
        openHabitView(with: habit)
    }
    
}
