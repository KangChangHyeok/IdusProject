//
//  RealTimeViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/30.
//

import UIKit
import Kingfisher
class RealTimeViewController: UIViewController {
    
    //MARK: - IBOutlet, property
    
    @IBOutlet weak var realTimeCollectionView: UICollectionView! {
        didSet {
            realTimeCollectionView.dataSource = self
            realTimeCollectionView.delegate = self
            realTimeCollectionView.register(UINib(nibName: RealTimeCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: RealTimeCollectionViewCell.cellId)
        }
    }
    private let dataManager = DataManager()
    private var products = [RealTimeAndNewResult]()
    private var starRating = [Double]()
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

//MARK: - extension

extension RealTimeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        dataManager.getRealTimeAndNewProductData { RealTimeAndNewProductData in
            self.products = RealTimeAndNewProductData.result
            self.products.forEach {
                if (Double($0.reviewStarRating) / Double($0.count)).isNaN {
                    self.starRating.append(0.0)
                } else {
                    self.starRating.append(round((Double($0.reviewStarRating) / Double($0.count)) * 10) / 10)
                }
            }
            self.realTimeCollectionView.reloadData()
        }
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RealTimeCollectionViewCell.cellId, for: indexPath) as! RealTimeCollectionViewCell
        cell.imageVIew.kf.setImage(with: URL(string: self.products[indexPath.row].productTitleImage))
        cell.imageVIew.contentMode = .scaleToFill
        cell.productTitle.text = self.products[indexPath.row].productTitle
        cell.reviewContent.text = self.products[indexPath.row].reviewContent
        cell.starRating.rating = self.starRating[indexPath.row]
        return cell
    }
    
    
}

extension RealTimeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let height: CGFloat = collectionView.frame.height / 2
        let width: CGFloat = (collectionView.frame.width / 2) - 20
        
        return CGSize(width: width, height:height)
    }
}
extension RealTimeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.productIdx = self.products[indexPath.row].productIdx
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
