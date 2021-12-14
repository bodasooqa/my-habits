//
//  TrackDateTableViewCell.swift
//  MyHabits
//
//  Created by t.lolaev on 14.12.2021.
//

import UIKit

class TrackDateTableViewCell: UITableViewCell {
    
    static let identifier: String = "track-date-cell"
    
    private lazy var dateFormatter: DateFormatter = {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "RU")
        
        return dateFormatter
    }()
    
    let habitsStore = HabitsStore.shared
    
    var date: Date?
    var habit: Habit?
    
    func set(date: Date, habit: Habit) {
        self.date = date
        self.habit = habit
        
        configureCell()
    }
    
    func configureCell() {
        if let date = date {
            textLabel?.text = getDateString(from: date)
            
            if let habit = habit, habitsStore.habit(habit, isTrackedIn: date) {
                accessoryView = UIImageView(image: .init(systemName: "checkmark"))
            } else {
                accessoryView = nil
            }
        }
    }
    
    private func getDateString(from date: Date) -> String {
        var dateString = dateFormatter.string(from: date)
        let now = Date.now
        
        if dateString == dateFormatter.string(from: now) {
            dateString = "Сегодня"
        } else if dateString == dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: now)!) {
            dateString = "Вчера"
        } else if dateString == dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -2, to: now)!) {
            dateString = "Позавчера"
        }
        
        return dateString
    }
    
}
