//
//  ProgramCollectionViewCell.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 20/06/23.
//

import UIKit

struct ProgramCollectionViewCellModel {
    
    let id: String
    let title: String
   
    
    init(title: String) {
        self.id = UUID().uuidString
        self.title = title
    }
}

class ProgramCollectionViewCell: UICollectionViewCell {
    
    struct Constants {
        static var titleLabelHorizontalPadding: CGFloat = 6
        static var titleFont: CGFloat = 17
        static var contentBorderWidth: CGFloat = 1.0
    }
    
    var model: ProgramCollectionViewCellModel?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: Constants.titleFont)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .programLightBlue : .programDarkBlue
        }
    }
    
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
        titleLabel.text = model?.title
    }
    
    func setup(model: ProgramCollectionViewCellModel) {
        self.model = model
        configureLayout()
    }
}
