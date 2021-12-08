//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by t.lolaev on 30.11.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "habit-cell"
    
    private let habitsStore: HabitsStore = .shared
    
    private var habit: Habit?
    
    lazy var titleLabel: UILabel = {
        titleLabel = .createHeadline()
        titleLabel.numberOfLines = 2
        
        return titleLabel
    }()
    
    lazy var captionLabel: UILabel = .createCaption()

    lazy var footnoteLabel: UILabel = .createFootnote()

    lazy var checkButton: UIButton = UIButton()
    
    var subViews: [UIView] {
        [titleLabel, captionLabel, footnoteLabel, checkButton]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureStyle()
    }
    
    private func configureStyle() {
        backgroundColor = .transparent
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    private func configureLayout() {
        subViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 220),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            captionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),

            footnoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            footnoteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            footnoteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 72),

            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            checkButton.widthAnchor.constraint(equalToConstant: 38),
            checkButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    public func set(habit: Habit) {
        self.habit = habit
        
        guard let habit = self.habit else {
            fatalError()
        }
        
        titleLabel.text = habit.name
        titleLabel.textColor = habit.color
        captionLabel.text = "Каждый день в \(habit.date)"
        footnoteLabel.text = "Счётчик: \(habit.trackDates.count)"
        checkButton.setBackgroundImage(UIImage(systemName: habit.isAlreadyTakenToday ? "checkmark.circle.fill" : "circle"), for: .normal)
        checkButton.tintColor = habit.color
        checkButton.addTarget(self, action: #selector(track), for: .touchUpInside)
    }
    
    @objc private func track() {
        guard let habit = habit else {
            fatalError()
        }
        
        if !habit.isAlreadyTakenToday {
            habitsStore.track(habit)
        }
    }
    
}
