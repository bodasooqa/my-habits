//
//  HabitView.swift
//  MyHabits
//
//  Created by t.lolaev on 02.12.2021.
//

import UIKit

class HabitView: UIView {
    
    lazy var titleProp: UILabel = .createProperty(with: "Название".uppercased())
    
    lazy var titleTextField: UITextField = {
        titleTextField = UITextField()
        titleTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        titleTextField.font = .systemFont(ofSize: 17, weight: .semibold)
        titleTextField.textColor = .systemBlue
        
        return titleTextField
    }()
    
    lazy var colorProp: UILabel = .createProperty(with: "Цвет".uppercased())
    
    lazy var colorButton: UIButton = {
        colorButton = UIButton(type: .custom)
        colorButton.backgroundColor = .appOrange
        colorButton.layer.cornerRadius = 15
        
        return colorButton
    }()
    
    lazy var timeProp: UILabel = .createProperty(with: "Время".uppercased())
    
    lazy var timePicker: UIDatePicker = {
        timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        return timePicker
    }()
    
    lazy var timeLabel: UILabel = .createBody()
    
    lazy var timeValue: UILabel = {
        timeValue = .createBody()
        timeValue.textColor = .appPurple
        
        return timeValue
    }()
    
    lazy var removeButton: UIButton = {
        removeButton = UIButton()
        removeButton.setTitle("Удалить привычку", for: .normal)
        removeButton.titleLabel?.font = .systemFont(ofSize: 17)
        removeButton.setTitleColor(.systemRed, for: .normal)
        
        return removeButton
    }()
    
    var subViews: [UIView] {
        [titleProp, titleTextField, colorProp, colorButton, timeProp, timeLabel, timeValue, timePicker, removeButton]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        subViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleProp.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleProp.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21),
            
            titleTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleTextField.topAnchor.constraint(equalTo: titleProp.bottomAnchor, constant: 7),
            titleTextField.heightAnchor.constraint(equalToConstant: 22),
            
            colorProp.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorProp.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            
            colorButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorButton.topAnchor.constraint(equalTo: colorProp.bottomAnchor, constant: 7),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeProp.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeProp.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            
            timeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: timeProp.bottomAnchor, constant: 7),
            
            timeValue.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            timeValue.topAnchor.constraint(equalTo: timeLabel.topAnchor),
            
            timePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            timePicker.topAnchor.constraint(equalTo: timeProp.bottomAnchor, constant: 35),
            
            removeButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            removeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18)
        ])
    }
    
}
