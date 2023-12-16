//
//  SearchView.swift
//  Idus
//
//  Created by 강창혁 on 12/16/23.
//

import UIKit

final class SearchView: BaseView {
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "크리스마스를 검색해보세요"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let glassImageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "magnifyingglass"))
        imageView.tintColor = .black
        return imageView
    }()
    
    override func configureDefaults() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
    }

    override func configureUI() {
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        glassImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchLabel)
        addSubview(glassImageView)
        
        NSLayoutConstraint.activate([
            searchLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            glassImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            glassImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            glassImageView.leadingAnchor.constraint(greaterThanOrEqualTo: searchLabel.trailingAnchor, constant: 20),
            glassImageView.heightAnchor.constraint(equalToConstant: 20),
            glassImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
