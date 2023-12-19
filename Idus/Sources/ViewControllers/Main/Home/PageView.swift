//
//  PageView.swift
//  Idus
//
//  Created by 강창혁 on 12/11/23.
//

import UIKit

final class PageView: UIView {
    
    let currentPageNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    let allPageNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "/ 10"
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var allBannerButton: UIButton = {
        var buttonConfig: UIButton.Configuration = .plain()
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .white
        buttonConfig.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        var attributedTitleString = AttributedString("전체보기")
        attributedTitleString.font = .systemFont(ofSize: 10, weight: .light)
        
        buttonConfig.attributedTitle = attributedTitleString
        
        let button = UIButton(configuration: buttonConfig)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {

        backgroundColor = .black.withAlphaComponent(0.5)
        layer.cornerRadius = 9
        layer.masksToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [
            currentPageNumberLabel,
            allPageNumberLabel,
            allBannerButton]
        )
        
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}
