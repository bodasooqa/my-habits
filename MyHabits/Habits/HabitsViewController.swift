//
//  MainViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    let habitsView = HabitsView()
    
    lazy var addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSomething))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Привычки"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(habitsView)
        habitsView.putIntoSafeArea(view: view)
        
        navigationItem.rightBarButtonItem = addBarButton
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        navigationController?.navigationBar.topItem?.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func addSomething() {
        print("Added")
    }
    
}
