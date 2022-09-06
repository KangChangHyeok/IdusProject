//
//  RealTimeViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/30.
//

import UIKit
import Kingfisher
class NewViewController: UIViewController {

    @IBOutlet weak var newCollectionView: UICollectionView!
    let getdata = DataManager()
    
    var productTitleImages = [String]()
    var productTitles = [String]()
    var starRatings = [Double]()
    var productReviewContents = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newCollectionView.register(UINib(nibName: RealTimeCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: RealTimeCollectionViewCell.cellId)
        newCollectionView.dataSource = self
        newCollectionView.delegate = self
        getdata.getRealTimeAndNewProductData { RealTimeAndNewProductData in
            for i in 0...RealTimeAndNewProductData.result.count - 1 {
                self.productTitleImages.append(RealTimeAndNewProductData.result[i].productTitleImage)
                self.productTitles.append(RealTimeAndNewProductData.result[i].productTitle)
                self.starRatings.append(Double(RealTimeAndNewProductData.result[i].reviewStarRating) / Double(RealTimeAndNewProductData.result[i].count))
                if self.starRatings[i].isNaN {
                    self.starRatings[i] = 0.0
                }
                
                self.productReviewContents.append(RealTimeAndNewProductData.result[i].reviewContent)
            }
            print(self.starRatings)
            self.newCollectionView.reloadData()
        }
    }
}

extension NewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RealTimeCollectionViewCell.cellId, for: indexPath) as! RealTimeCollectionViewCell
            cell.imageVIew.kf.setImage(with: URL(string: productTitleImages[indexPath.row]))
            cell.imageVIew.contentMode = .scaleToFill
            cell.productTitle.text = self.productTitles[indexPath.row]
            cell.reviewContent.text = self.productReviewContents[indexPath.row]
        cell.starRating.rating = Double(self.starRatings[indexPath.row])
        
        return cell
    }
    
    
}

extension NewViewController: UICollectionViewDelegateFlowLayout {
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
