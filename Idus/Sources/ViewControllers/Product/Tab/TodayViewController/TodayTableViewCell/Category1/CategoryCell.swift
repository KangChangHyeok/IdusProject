//
//  CategoryCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit
import Kingfisher

protocol CollectionViewCellDelegate {
    func selectedCell(_ productIdx: Int)
}

class CategoryCell: UITableViewCell {

    
    static let cellId = "CategoryCell"
    static let className = "CategoryCell"
    @IBOutlet weak var CategoryCellCollectionView: UICollectionView!
    @IBOutlet weak var productNameImageView: UIImageView!
    
    var delegate: CollectionViewCellDelegate?
    
    var images = [String]()
    var productNames = [String]()
    var productReviews = [String?]()
    var productIdx = [Int]()
    var productCategoryIdx = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CategoryCellCollectionView.dataSource = self
        CategoryCellCollectionView.delegate = self
        CategoryCellCollectionView.register(UINib(nibName: CategoryCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier : CategoryCollectionViewCell.cellId)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.cellId, for: indexPath) as! CategoryCollectionViewCell
        cell.imageVIew.kf.setImage(with: URL(string: self.images[indexPath.row]))
        cell.imageVIew?.contentMode = .scaleToFill
        cell.productName.text = self.productNames[indexPath.row]
        cell.productReview.text = self.productReviews[indexPath.row]
        return cell
    }
    
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height
        let width: CGFloat = collectionView.frame.width / 3
        
        return CGSize(width: width, height:height)
    }
}

extension CategoryCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.selectedCell(productIdx[indexPath.row])
        productNameImageView.kf.setImage(with: URL(string: self.images[indexPath.row]))
        
    }
}
