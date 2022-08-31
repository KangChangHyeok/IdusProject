//
//  CollectionViewCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/06.
//

import UIKit
import Cosmos
class ReviewCell: UICollectionViewCell {

    static let cellId = "ReviewCell"
    static let className = "ReviewCell"
    
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var reviewText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
