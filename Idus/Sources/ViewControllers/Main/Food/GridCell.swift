//
//  GridCell.swift
//  Idus
//
//  Created by KangChangHyeok on 3/26/24.
//

import UIKit

final class GridCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .randomColor
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
