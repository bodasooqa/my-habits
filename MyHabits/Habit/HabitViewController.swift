//
//  HabitViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 01.12.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    let habitView = HabitView(frame: .zero)
    
    var saveCompletion: (() -> Void)?
    
    private lazy var habitsStore: HabitsStore = .shared
    
    private lazy var colorPicker: UIColorPickerViewController = {
        colorPicker = UIColorPickerViewController()
        
        return colorPicker
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
    private var selectedTime: Date {
        habitView.timePicker.date
    }
    
    private var formattedTime: String {
        dateFormatter.string(from: selectedTime)
    }
    
    private var selectedColor: UIColor {
        colorPicker.selectedColor
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        title = "Создать"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(habitView)
        habitView.putIntoSafeArea(view: view)
        
        configureNavigationBar()
        
        colorPicker.delegate = self
        colorPicker.selectedColor = habitView.colorButton.backgroundColor ?? .appOrange
        
        habitView.colorButton.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        habitView.timePicker.addTarget(self, action: #selector(setTime), for: .valueChanged)
        setTime()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Необходимо указать название", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func showColorPicker() {
        present(colorPicker, animated: true, completion: nil)
    }
    
    @objc private func setTime() {
        habitView.timeValue.text = formattedTime
    }
    
    @objc private func save() {
        guard let title = habitView.titleTextField.text, !title.isEmpty else {
            showErrorAlert()
            return
        }
        let habit = Habit(name: title, date: selectedTime, color: selectedColor)
        habitsStore.habits.append(habit)
        print(habitsStore.habits.count)
        dismissSelf()
        saveCompletion?()
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitView.colorButton.backgroundColor = selectedColor
    }
    
}
