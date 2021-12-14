//
//  HabitViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 01.12.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    let habitView = HabitView(frame: .zero)
    
    var saveCompletion: ((_ toStart: Bool?) -> Void)?
    
    var isEdit: Bool = false {
        didSet(_value) {
            title = isEdit ? "Править" : "Создать"
            habitView.removeButton.isHidden = !isEdit
        }
    }
    
    var habit: Habit? = nil {
        didSet(_value) {
            if let habit = habit {
                habitView.titleTextField.text = habit.name
                habitView.colorButton.backgroundColor = habit.color
                colorPicker.selectedColor = habit.color
                habitView.timeValue.text = dateFormatter.string(from: habit.date)
                habitView.timePicker.date = habit.date
            } else {
                let date = Date()
                habitView.titleTextField.text = ""
                habitView.timeValue.text = dateFormatter.string(from: date)
                habitView.timePicker.date = date
            }
        }
    }
    var habitIndex: Int?
    
    private lazy var habitsStore: HabitsStore = .shared
    
    private lazy var colorPicker: UIColorPickerViewController = UIColorPickerViewController()
    
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
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureNavigationBar()
        configureColorPicker()
        configureElements()
    }
    
    private func configureLayout() {
        view.addSubview(habitView)
        habitView.putIntoSafeArea(view: view)
    }
    
    private func configureElements() {
        habitView.removeButton.isHidden = !isEdit
        habitView.colorButton.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        habitView.timePicker.addTarget(self, action: #selector(setTime), for: .valueChanged)
        habitView.removeButton.addTarget(self, action: #selector(removeHabit), for: .touchUpInside)
        setTime()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    private func configureColorPicker() {
        colorPicker.delegate = self
        colorPicker.selectedColor = habitView.colorButton.backgroundColor ?? .appOrange
    }
    
    private func configureStyle() {
        view.backgroundColor = .white
        title = isEdit ? "Править" : "Создать"
    }
    
    private func createAlert(title: String, message: String, actionLabel: String, action: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionLabel, style: .default, handler: action))
        
        return alert
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Необходимо указать название", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .default))
        
        present(alert, animated: true)
    }
    
    private func showRemoveHabitAlert() {
        if let habit = habit {
            let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(habit.name)\"?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .default))
            alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
                self.removeHabitHandler()
            }))
            
            present(alert, animated: true)
        }
    }
    
    private func removeHabitHandler() {
        habitsStore.habits.removeAll { $0.name == habit?.name }
        dismissSelf(toStart: true)
    }
    
    @objc private func dismissSelf(toStart: Bool = false) {
        dismiss(animated: true, completion: nil)
        saveCompletion?(toStart)
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
        
        if isEdit {
            if let habitIndex = habitIndex {
                habitsStore.habits[habitIndex].name = habit.name
                habitsStore.habits[habitIndex].date = habit.date
                habitsStore.habits[habitIndex].color = habit.color
            }
        } else {
            habitsStore.habits.append(habit)
        }
        
        dismissSelf()
    }
    
    @objc private func removeHabit() {
        showRemoveHabitAlert()
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitView.colorButton.backgroundColor = selectedColor
    }
    
}
