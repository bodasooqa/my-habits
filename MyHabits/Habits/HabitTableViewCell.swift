//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by t.lolaev on 30.11.2021.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    static let identifier: String = "habit-cell"
    static let spacing: CGFloat = 12
    
    private let habitsStore: HabitsStore = .shared
    
    private var habit: Habit? = nil
    
    lazy var titleLabel: UILabel = {
        titleLabel = .createHeadline(with: "Headline")
        titleLabel.numberOfLines = 2
        
        return titleLabel
    }()
    
    lazy var captionLabel: UILabel = {
        captionLabel = .createCaption(with: "Caption")
        
        return captionLabel
    }()
    
    lazy var footnoteLabel: UILabel = {
        footnoteLabel = .createFootnote(with: "Footnote")
        
        return footnoteLabel
    }()
    
    lazy var checkButton: UIButton = {
        checkButton = UIButton()
        checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        
        return checkButton
    }()
    
    var subViews: [UIView] {
        [titleLabel, captionLabel, footnoteLabel, checkButton]
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectionStyle = .none
        backgroundColor = .init(white: 0, alpha: 0)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: Self.spacing, left: 0, bottom: 0, right: 0))
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
            
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            checkButton.widthAnchor.constraint(equalToConstant: 38),
            checkButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    public func set(habit: Habit) {
        self.habit = habit
        
        if let habit = self.habit {
            titleLabel.text = habit.name
            titleLabel.textColor = habit.color
            captionLabel.text = "Каждый день в \(habit.date)"
            footnoteLabel.text = "Счётчик: \(habit.trackDates.count)"
            checkButton.setBackgroundImage(UIImage(systemName: habit.isAlreadyTakenToday ? "checkmark.circle.fill" : "circle"), for: .normal)
            checkButton.tintColor = habit.color
            
            checkButton.addTarget(self, action: #selector(track), for: .touchUpInside)
        }
    }
    
    @objc private func track() {
        let habit = habit!
        if !habit.isAlreadyTakenToday {
            habitsStore.track(habit)
        }
    }
    
}
