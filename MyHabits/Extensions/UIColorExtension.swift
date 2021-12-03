//
//  UIColorExtension.swift
//  MyHabits
//
//  Created by t.lolaev on 04.12.2021.
//

import UIKit

extension UIColor {
    
    static var appBlue: UIColor {
        UIColor(named: "Blue") ?? .systemBlue
    }
    
    static var appPurple: UIColor {
        UIColor(named: "Purple") ?? .systemPurple
    }
    
    static var appOrange: UIColor {
        UIColor(named: "Orange") ?? .systemOrange
    }
    
    static var appLightGray: UIColor {
        UIColor(named: "LightGray") ?? .systemGray
    }
    
}
