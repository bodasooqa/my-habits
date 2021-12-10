//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by t.lolaev on 04.12.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "progress"
    
    private let spacing: CGFloat = 18
    
    var progress: Float = 0 {
        didSet(_value) {
            progressValue.text = "\(Int(progress * 100))%"
            progressView.setProgress(progress, animated: true)
        }
    }
    
    lazy var progressLabel: UILabel = .createProgressFoonote(with: "Все получится")
    
    lazy var progressValue: UILabel = .createProgressFoonote()
    
    lazy var progressView: UIProgressView = {
        progressView = UIProgressView()
        progressView.layer.cornerRadius = 3.5
        
        return progressView
    }()
    
    var subViews: [UIView] {
        [progressLabel, progressValue, progressView]
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
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            progressValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7),
        ])
    }
    
}
