//
//  CategoryCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit
import Kingfisher

protocol CollectionView3CellDelegate {
    func selected3Cell(_ productIdx: Int)
}

class Category3Cell: UITableViewCell {

    
    static let cellId = "Category3Cell"
    static let className = "Category3Cell"
    
    @IBOutlet weak var category3CellCollectionView: UICollectionView!
    @IBOutlet weak var category3CellProductImage: UIImageView!
    
    var delegate: CollectionView3CellDelegate?
    
    var images = [String]()
    var productNames = [String]()
    var productReviews = [String?]()
    var productIdx = [Int]()
    var productCategoryIdx = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        category3CellCollectionView.dataSource = self
        category3CellCollectionView.delegate = self
        category3CellCollectionView.register(UINib(nibName: Category3CollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier : Category3CollectionViewCell.cellId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension Category3Cell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Category3CollectionViewCell.cellId, for: indexPath) as! Category3CollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: self.images[indexPath.row]))
        cell.imageView?.contentMode = .scaleToFill
        cell.productName.text = self.productNames[indexPath.row]
        cell.productReview.text = self.productReviews[indexPath.row]
        return cell
    }
    
}

extension Category3Cell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height
        let width: CGFloat = collectionView.frame.width / 3
        
        return CGSize(width: width, height:height)
    }
}

extension Category3Cell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selected3Cell(self.productIdx[indexPath.row])
        self.category3CellProductImage.kf.setImage(with: URL(string: self.images[indexPath.row]))
        
    }
}
