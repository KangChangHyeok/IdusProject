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

    //MARK: - IBOutlet, property
    
    @IBOutlet weak var CategoryCellCollectionView: UICollectionView! {
        didSet {
            CategoryCellCollectionView.dataSource = self
            CategoryCellCollectionView.delegate = self
            CategoryCellCollectionView.register(UINib(nibName: CategoryCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier : CategoryCollectionViewCell.cellId)
        }
    }
    @IBOutlet weak var productNameImageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    static let cellId = "CategoryCell"
    static let className = "CategoryCell"
    
    var delegate: CollectionViewCellDelegate?
    var products = [Product]()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.cellId, for: indexPath) as! CategoryCollectionViewCell
        cell.imageVIew.kf.setImage(with: URL(string: products[indexPath.row].productTitleImage))
        cell.imageVIew?.contentMode = .scaleToFill
        cell.productName.text = products[indexPath.row].productTitle
        cell.productReview.text = products[indexPath.row].reviewContent
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
        
        delegate?.selectedCell(products[indexPath.row].productIdx)
        productNameImageView.kf.setImage(with: URL(string: products[indexPath.row].productTitleImage))
        
    }
}
