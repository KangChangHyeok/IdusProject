//
//  BannerCell.swift
//  Idus
//
//  Created by KangChangHyeok on 3/25/24.
//

import UIKit

final class BannerCVCell: UICollectionViewCell, Reusable {
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .randomColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBannerImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBannerImageView() {
        contentView.addSubview(bannerImageView)
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func bind(imageURLString: String?) {
        guard let imageURLString, let imageURL = URL(string: imageURLString) else { return }
        bannerImageView.setImage(url: imageURL)
    }
    
}
