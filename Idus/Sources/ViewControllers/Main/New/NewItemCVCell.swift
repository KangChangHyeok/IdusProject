//
//  NewItemCVCell.swift
//  Idus
//
//  Created by KangChangHyeok on 5/1/24.
//

import UIKit

final class NewItemCVCell: UICollectionViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .randomColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(index: Int) {
        label.text = index.description
    }
}
