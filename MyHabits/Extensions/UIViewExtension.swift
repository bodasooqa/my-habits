//
//  UIViewExtension.swift
//  MyHabits
//
//  Created by t.lolaev on 29.11.2021.
//

import UIKit

extension UIView {
    func putIntoSafeArea(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            self.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
}
