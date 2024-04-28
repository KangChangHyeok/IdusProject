//
//  GridSectionFooterView.swift
//  Idus
//
//  Created by KangChangHyeok on 4/23/24.
//

import UIKit

final class GridSectionFooterView: UICollectionReusableView {
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        return pageControl
    }()
    
    private lazy var moreButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()
        let imageConfig = UIImage.SymbolConfiguration(scale: .medium)
        let buttonImage = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        buttonConfig.image = buttonImage
        buttonConfig.imagePadding = 5
        buttonConfig.title = "작품 더보기"
        buttonConfig.baseForegroundColor = .black
        buttonConfig.background.strokeColor = .gray
        buttonConfig.background.backgroundColor = .white
        buttonConfig.imagePlacement = .trailing
        buttonConfig.background.strokeWidth = 1
        buttonConfig.background.cornerRadius = 20
        let button = UIButton(configuration: buttonConfig)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(pageControl)
        addSubview(moreButton)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: self.topAnchor),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            moreButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 5),
            moreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 40),
            moreButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
