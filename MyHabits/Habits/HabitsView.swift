//
//  MainView.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

class HabitsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(named: "LightGray")
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
