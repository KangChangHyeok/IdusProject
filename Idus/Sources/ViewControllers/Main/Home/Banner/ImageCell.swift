//
//  ImageCell.swift
//  Idus
//
//  Created by 강창혁 on 12/19/23.
//

import UIKit

final class ImageCell: UITableViewCell, Reusable {
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
