//
//  CategoryCollectionViewCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit

class Category3CollectionViewCell: UICollectionViewCell {

    static let cellId = "Category3CollectionViewCell"
    static let className = "Category3CollectionViewCell"
    
    var productIdx : Int?
    var productCategoryIdx : Int?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productReview: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
