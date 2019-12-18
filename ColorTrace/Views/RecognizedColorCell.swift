//
//  RecognizedColorCell.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 10.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import UIKit

class RecognizedColorCell: UITableViewCell {
    
    private lazy var nameColor: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "nameColor"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        let font = UIFont.boldSystemFont(ofSize: 14)
        label.font = font
        label.backgroundColor = .orange
        return label
    }()
    
    private lazy var descript: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "descript"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        let font = UIFont.boldSystemFont(ofSize: 14)
        label.font = font
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.accessibilityIdentifier = "photo"
        imageView.frame.origin = CGPoint.zero
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    private(set) var recognizedColor: RecognizedColorModel?{
        didSet{
            nameColor.text = recognizedColor?.nameColor
            descript.text = recognizedColor?.description
            photo.image = recognizedColor?.image
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .darkGray
        addSubview(photo)
        addSubview(descript)
        addSubview(nameColor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ model: RecognizedColorModel) {
        recognizedColor = model
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
    private func setConstraint() {
       let const = [
        photo.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.0),
        photo.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
        photo.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2.0),
        photo.widthAnchor.constraint(equalToConstant: 100),
        photo.heightAnchor.constraint(equalToConstant: 100),
        
        nameColor.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
        nameColor.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.0),
        nameColor.trailingAnchor.constraint(equalTo: photo.leadingAnchor, constant: -2.0),
        nameColor.bottomAnchor.constraint(equalTo: descript.topAnchor, constant: -2.0),
        nameColor.heightAnchor.constraint(equalToConstant: 30),
        
        descript.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
        descript.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2.0),
        descript.trailingAnchor.constraint(equalTo: photo.leadingAnchor, constant: -2.0),

        ]
        NSLayoutConstraint.activate(const)
    }
}
