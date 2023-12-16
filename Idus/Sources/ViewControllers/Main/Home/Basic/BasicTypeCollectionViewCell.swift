//
//  BasicTypeCollectionViewCell.swift
//  Idus
//
//  Created by 강창혁 on 12/5/23.
//

import UIKit

final class BasicTypeCollectionViewCell: UICollectionViewCell, Reusable {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .randomColor
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "상품 내용이 보여지는 텍스트입니다."
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productNameLabel.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
    
    func configure(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        productImageView.setImage(url: url)
    }
}

