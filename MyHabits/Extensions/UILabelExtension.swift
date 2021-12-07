//
//  UILabelExtension.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

extension UILabel {
    
    private static func createLabel(with text: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: size, weight: weight)
        label.text = text
        label.textColor = color
        
        return label
    }
    
    static func createTitle3(with text: String, color: UIColor = .black) -> UILabel {
        return createLabel(with: text, size: 20, weight: .semibold, color: color)
    }
    
    static func createHeadline(with text: String, color: UIColor = .black) -> UILabel {
        return createLabel(with: text, size: 17, weight: .semibold, color: color)
    }
    
    static func createCaption(with text: String, color: UIColor = .systemGray2) -> UILabel {
        return createLabel(with: text, size: 12, weight: .regular, color: color)
    }
    
    static func createFootnote(with text: String, color: UIColor = .systemGray) -> UILabel {
        return createLabel(with: text, size: 13, weight: .regular, color: color)
    }
    
    static func createProperty(with text: String, color: UIColor = .black) -> UILabel {
        return createLabel(with: text, size: 13, weight: .semibold, color: color)
    }
    
    static func createBody(with text: String, color: UIColor = .black) -> UILabel {
        return createLabel(with: text, size: 17, weight: .regular, color: color)
    }
    
    static func createProgressFoonote(with text: String, color: UIColor = .systemGray) -> UILabel {
        return createLabel(with: text, size: 13, weight: .semibold, color: color)
    }
    
}
