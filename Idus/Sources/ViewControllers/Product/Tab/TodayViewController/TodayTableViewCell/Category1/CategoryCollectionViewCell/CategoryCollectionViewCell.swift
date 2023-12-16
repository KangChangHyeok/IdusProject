//
//  CategoryCollectionViewCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let cellId = "CategoryCollectionViewCell"
    static let className = "CategoryCollectionViewCell"
    var productIdx : Int?
    var productCategoryIdx : Int?
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productReview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
