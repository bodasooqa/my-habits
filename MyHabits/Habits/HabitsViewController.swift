//
//  MainViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Привычки"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = HabitsView()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Сегодня"
    }
    
    @objc private func addHabit() {
        let navVC = UINavigationController(rootViewController: HabitViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
}
