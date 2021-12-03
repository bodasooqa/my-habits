//
//  HabitViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 01.12.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    let habitView = HabitView(frame: .zero)
    
    lazy var colorPicker: UIColorPickerViewController = {
        colorPicker = UIColorPickerViewController()
        
        return colorPicker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
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
        
        habitView.colorButton.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        habitView.timePicker.addTarget(self, action: #selector(setTime), for: .valueChanged)
        setTime()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func showColorPicker() {
        present(colorPicker, animated: true, completion: nil)
    }
    
    @objc private func setTime() {
        habitView.timeValue.text = dateFormatter.string(from: habitView.timePicker.date)
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitView.colorButton.backgroundColor = colorPicker.selectedColor
    }
    
}
