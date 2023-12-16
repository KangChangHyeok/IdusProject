//
//  CategoryCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit
import Kingfisher

protocol CollectionView2CellDelegate {
    func selected2Cell(_ productIdx: Int)
}

class Category2Cell: UITableViewCell {

    
    static let cellId = "Category2Cell"
    static let className = "Category2Cell"
    
    var delegate: CollectionView2CellDelegate?
    
    @IBOutlet weak var category2CellCollectionView: UICollectionView!
    @IBOutlet weak var category2CellProductImage: UIImageView!
    
    var images = [String]()
    var productNames = [String]()
    var productReviews = [String?]()
    var productIdx = [Int]()
    var productCategoryIdx = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        category2CellCollectionView.dataSource = self
        category2CellCollectionView.delegate = self
        category2CellCollectionView.register(UINib(nibName: Category2CollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier : Category2CollectionViewCell.cellId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension Category2Cell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Category2CollectionViewCell.cellId, for: indexPath) as! Category2CollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: self.images[indexPath.row]))
        cell.imageView?.contentMode = .scaleToFill
        cell.productName.text = self.productNames[indexPath.row]
        cell.productReview.text = self.productReviews[indexPath.row]
        return cell
    }
    
}

extension Category2Cell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height
        let width: CGFloat = collectionView.frame.width / 3
        
        return CGSize(width: width, height:height)
    }
}

extension Category2Cell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selected2Cell(productIdx[indexPath.row])
        self.category2CellProductImage.kf.setImage(with: URL(string: self.images[indexPath.row]))
        
    }
}
