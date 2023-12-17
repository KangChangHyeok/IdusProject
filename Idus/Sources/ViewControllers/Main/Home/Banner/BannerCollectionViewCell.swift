//
//  BannerCollectionViewCell.swift
//  Idus
//
//  Created by 강창혁 on 2023/11/28.
//

import UIKit

final class BannerCollectionViewCell: UICollectionViewCell, Reusable {
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        bannerImageView.image = nil
    }
    
    func setUpUI() {
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bannerImageView)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(imageURLString: String?) {
        guard let imageURLString, let imageURL = URL(string: imageURLString) else { return }
        bannerImageView.setImage(url: imageURL)
    }
}
