//
//  CategoryCollectionViewCell.swift
//  Idus
//
//  Created by 강창혁 on 11/29/23.
//

import UIKit

final class CategoryItemCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - Properties
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .randomColor
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    func configure(image: UIImage?, text: String) {
        categoryImageView.image = image
        categoryLabel.text = text
    }
    
}
