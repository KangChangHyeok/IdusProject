//
//  BasicTypeCollectionViewFooterView.swift
//  Idus
//
//  Created by 강창혁 on 12/6/23.
//

import UIKit

final class BasicTypeCollectionViewFooterView: UICollectionReusableView, Reusable {
      
    private lazy var moreViewButton: UIButton = {
        var buttonConfig: UIButton.Configuration = .plain()
        buttonConfig.baseBackgroundColor = .white
        buttonConfig.baseForegroundColor = .black
        
        buttonConfig.image = .init(systemName: "arrow.right")
        buttonConfig.imagePlacement = .top
        buttonConfig.imagePadding = 5
        
        var attributedTitleString = AttributedString("더보기")
        attributedTitleString.font = UIFont.systemFont(ofSize: 13, weight: .light)
        
        buttonConfig.attributedTitle = attributedTitleString
        
        let button = UIButton(configuration: buttonConfig)
        return button
    }()
    
    override func layoutSubviews() {
        addSubview(moreViewButton)
        moreViewButton.frame = bounds
    }
}
