//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by t.lolaev on 30.11.2021.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    public static let identifier: String = "habit-cell"
    
    lazy var titleLabel: UILabel = {
        titleLabel = .createHeadline(with: "Headline")
        titleLabel.numberOfLines = 2
        
        return titleLabel
    }()
    
    lazy var captionLabel: UILabel = {
        captionLabel = .createCaption(with: "Caption")
        
        return captionLabel
    }()
    
    lazy var footnoteLabel: UILabel = {
        footnoteLabel = .createFootnote(with: "Footnote")
        
        return footnoteLabel
    }()
    
    lazy var checkImage: UIImageView = {
        checkImage = UIImageView(image: UIImage(systemName: "circle"))
        checkImage.layer.masksToBounds = false
        checkImage.clipsToBounds = true
        
        return checkImage
    }()
    
    var subViews: [UIView] {
        [titleLabel, captionLabel, footnoteLabel, checkImage]
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
    }
    
    private func configureLayout() {
        subViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 220),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            captionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            footnoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            footnoteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            checkImage.widthAnchor.constraint(equalToConstant: 38),
            checkImage.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
}
