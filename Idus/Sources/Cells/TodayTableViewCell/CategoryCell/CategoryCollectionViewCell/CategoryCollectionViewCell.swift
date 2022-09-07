//
//  CategoryCollectionViewCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet, property
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productReview: UILabel!
    
    static let cellId = "CategoryCollectionViewCell"
    static let className = "CategoryCollectionViewCell"
    
    //MARK: - override Method
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
