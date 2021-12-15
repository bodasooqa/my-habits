//
//  InfoViewController.swift
//  MyHabits
//
//  Created by t.lolaev on 30.11.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    lazy var infoView = InfoView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Информация"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(infoView)
        infoView.putIntoSafeArea(view: view)
    }
    
}
