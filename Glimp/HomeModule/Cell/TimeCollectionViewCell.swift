//
//  TimeCollectionViewCell.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 18/06/23.
//

import UIKit


struct TimeCollectionViewCellModel {
    let id: String
    let date: String
    
    init(date: String) {
        self.id = UUID().uuidString
        self.date = date
        
    }
}

class TimeCollectionViewCell: UICollectionViewCell {
    
    struct Constants {
        static var titleLabelHorizontalPadding: CGFloat = 6
        static var titleFont: CGFloat = 17
        static var contentBorderWidth: CGFloat = 1.0
    }
    
    var model: TimeCollectionViewCellModel?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: Constants.titleFont)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    func configureLayout() {
        self.backgroundColor = UIColor.programDarkBlue
        self.layer.borderWidth = Constants.contentBorderWidth
        self.layer.borderColor = UIColor.white.cgColor
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.titleLabelHorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.titleLabelHorizontalPadding),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        titleLabel.text = model?.date
    }
    
    func setup(model: TimeCollectionViewCellModel) {
        self.model = model
        configureLayout()
    }
}
