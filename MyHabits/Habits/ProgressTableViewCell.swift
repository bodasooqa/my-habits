//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by t.lolaev on 04.12.2021.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    static let identifier: String = "progress"
    static let spacing: CGFloat = 18
    
    var progress: Float = 0 {
        didSet(_value) {
            progressValue.text = "\(Int(progress * 100))%"
            progressView.setProgress(progress, animated: true)
        }
    }
    
    lazy var progressLabel: UILabel = {
        progressLabel = .createProgressFoonote(with: "Все получится")
        
        return progressLabel
    }()
    
    lazy var progressValue: UILabel = {
        progressValue = .createProgressFoonote(with: "")
        
        return progressValue
    }()
    
    lazy var progressView: UIProgressView = {
        progressView = UIProgressView()
        progressView.layer.cornerRadius = 3.5
        
        return progressView
    }()
    
    var subViews: [UIView] {
        [progressLabel, progressValue, progressView]
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: Self.spacing, left: 0, bottom: 6, right: 0))
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
            progressView.heightAnchor.constraint(equalToConstant: 7),
        ])
    }
    
}
