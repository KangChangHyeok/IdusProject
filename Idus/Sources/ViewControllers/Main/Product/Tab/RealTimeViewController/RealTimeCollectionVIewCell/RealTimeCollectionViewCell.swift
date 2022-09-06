//
//  RealTimeCollectionViewCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/05.
//

import UIKit
import Cosmos
class RealTimeCollectionViewCell: UICollectionViewCell {

    static let cellId = "RealTimeCollectionViewCell"
    static let className = "RealTimeCollectionViewCell"
    
    
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var reviewContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
