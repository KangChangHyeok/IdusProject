//
//  headerView.swift
//  Idus
//
//  Created by 강창혁 on 12/19/23.
//

import UIKit

final class HeaderView: BaseView {
    
    lazy var dismissButton: UIButton = {
        var buttonConfig: UIButton.Configuration = .plain()
        buttonConfig.baseBackgroundColor = .white
        buttonConfig.baseForegroundColor = .black
        buttonConfig.image = .init(systemName: "xmark")
        
        let button = UIButton(configuration: buttonConfig)
        return button
    }()
    
    private let bannerCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()
    
    override func configureDefaults() {
        backgroundColor = .white
    }
    
    override func configureUI() {
        configureDissmissButtonConstraints()
        configureBannerCountLabelConstraints()
    }
    
    func configureDissmissButtonConstraints() {
        addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: topAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configureBannerCountLabelConstraints() {
        addSubview(bannerCountLabel)
        bannerCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerCountLabel.leadingAnchor.constraint(equalTo: dismissButton.trailingAnchor),
            bannerCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func bind(count bannerCount: Int) {
        bannerCountLabel.text = "이벤트 전체보기 (\(bannerCount))"
    }
}
