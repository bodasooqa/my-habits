//
//  UILabelExtension.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

extension UILabel {
    
    func createTitle3(with text: String, color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = text
        label.textColor = color
        
        return label
    }
    
}
