//
//  BannerCategoryCell.swift
//  Idus
//
//  Created by KangChangHyeok on 4/28/24.
//

import UIKit

final class BannerCategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .randomColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
