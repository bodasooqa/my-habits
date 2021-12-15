//
//  TabBarController.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let controllers = [
        UINavigationController(rootViewController: HabitsViewController()),
        UINavigationController(rootViewController: InfoViewController())
    ]
    
    private let images = [
        UIImage(systemName: "rectangle.grid.1x2.fill"),
        UIImage(systemName: "info.circle.fill")
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setViewControllers(controllers, animated: false)
        tabBar.tintColor = .appPurple
        
        guard let tabItems = tabBar.items else {
            return
        }
        
        for (idx, tabItem) in tabItems.enumerated() {
            tabItem.image = images.compactMap { $0 }[idx]
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
