//
//  TodayViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/30.
//

import UIKit
import Alamofire
import FSPagerView
import Kingfisher
class TodayViewController2: UIViewController {
    
    let getdata = DataManager()
    
    @IBOutlet weak var todayTableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        todayTableV.dataSource = self
        todayTableV.register(UINib(nibName: BannerTableViewCell.className, bundle: nil), forCellReuseIdentifier: BannerTableViewCell.cellId)
        todayTableV.register(UINib(nibName: MenuTableViewCell.className, bundle: nil), forCellReuseIdentifier: MenuTableViewCell.cellId)
        todayTableV.register(UINib(nibName: CategoryCell.className, bundle: nil), forCellReuseIdentifier: CategoryCell.cellId)
        todayTableV.register(UINib(nibName: Category2Cell.className, bundle: nil), forCellReuseIdentifier: Category2Cell.cellId)
        todayTableV.register(UINib(nibName: Category3Cell.className, bundle: nil), forCellReuseIdentifier: Category3Cell.cellId)
        
    }
}


extension TodayViewController2: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            //MARK: - 배너
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.cellId, for: indexPath) as! BannerTableViewCell
            self.getdata.getTodayProductData { TodayProductData in
                cell.bannerCount = TodayProductData.result.banners.count
                for i in 0...cell.bannerCount - 1 {
                    cell.bannerImages.append(TodayProductData.result.banners[i].bannerImageURL)
                }
                cell.imagearea.reloadData()
            }
            return cell
            //MARK: - 메뉴
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.cellId, for: indexPath) as! MenuTableViewCell
            return cell
            //MARK: - Category 1()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.cellId, for: indexPath) as! CategoryCell
            self.getdata.getTodayProductData { TodayProductData in
                for i in 0...TodayProductData.result.category1.count - 1 {
                    cell.images.append(TodayProductData.result.category1[i].productTitleImage!)
                }
                for i in 0...TodayProductData.result.category1.count - 1 {
                    cell.productNames.append(TodayProductData.result.category1[i].productTitle)
                }
                for i in 0...TodayProductData.result.category1.count - 1 {
                    cell.productReviews.append(TodayProductData.result.category1[i].reviewContent ?? "")
                }
                for i in 0...TodayProductData.result.category1.count - 1 {
                    cell.productIdx.append(TodayProductData.result.category1[i].productIdx)
                }
                for i in 0...TodayProductData.result.category1.count - 1 {
                    cell.productCategoryIdx.append(TodayProductData.result.category1[i].productCategoryIdx)
                }
                cell.delegate = self
                cell.CategoryCellCollectionView.reloadData()
            }
            return cell
            //MARK: - Category 2()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Category2Cell.cellId, for: indexPath) as! Category2Cell
            self.getdata.getTodayProductData { TodayProductData in
                for i in 0...TodayProductData.result.category2.count - 1 {
                    cell.images.append(TodayProductData.result.category2[i].productTitleImage!)
                }
                for i in 0...TodayProductData.result.category2.count - 1 {
                    cell.productNames.append(TodayProductData.result.category2[i].productTitle)
                }
                for i in 0...TodayProductData.result.category2.count - 1 {
                    cell.productReviews.append(TodayProductData.result.category2[i].reviewContent ?? "")
                }
                for i in 0...TodayProductData.result.category2.count - 1 {
                    cell.productIdx.append(TodayProductData.result.category2[i].productIdx)
                }
                for i in 0...TodayProductData.result.category2.count - 1 {
                    cell.productCategoryIdx.append(TodayProductData.result.category2[i].productCategoryIdx)
                }
                cell.delegate = self
                cell.category2CellCollectionView.reloadData()
            }
            return cell
            //MARK: - Category 3()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: Category3Cell.cellId, for: indexPath) as! Category3Cell
            self.getdata.getTodayProductData { TodayProductData in
                for i in 0...TodayProductData.result.category3.count - 1 {
                    cell.images.append(TodayProductData.result.category3[i].productTitleImage!)
                }
                for i in 0...TodayProductData.result.category3.count - 1 {
                    cell.productNames.append(TodayProductData.result.category3[i].productTitle)
                }
                for i in 0...TodayProductData.result.category3.count - 1 {
                    cell.productReviews.append(TodayProductData.result.category3[i].reviewContent ?? "")
                }
                for i in 0...TodayProductData.result.category3.count - 1 {
                    cell.productIdx.append(TodayProductData.result.category3[i].productIdx)
                }
                for i in 0...TodayProductData.result.category3.count - 1 {
                    cell.productCategoryIdx.append(TodayProductData.result.category3[i].productCategoryIdx)
                }
                cell.delegate = self
                cell.category3CellCollectionView.reloadData()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension TodayViewController2: CollectionViewCellDelegate {
    func selectedCell(_ productIdx: Int) {
        guard let detailViewNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewNavigationController") as? DetailViewNavigationController else {return}
        detailViewNavigationController.modalPresentationStyle = .fullScreen
        DetailViewController.productIdx = productIdx
        presentFromRight()
                present(detailViewNavigationController, animated: false) {
                    
        }
    }
}
extension TodayViewController2: CollectionView2CellDelegate {
    func selected2Cell(_ productIdx: Int) {
        guard let detailViewNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewNavigationController") as? DetailViewNavigationController else {return}
        detailViewNavigationController.modalPresentationStyle = .fullScreen
        DetailViewController.productIdx = productIdx
        presentFromRight()
        present(detailViewNavigationController, animated: false) {
            
        }
    }
}
extension TodayViewController2: CollectionView3CellDelegate {
    func selected3Cell(_ productIdx: Int) {
        guard let detailViewNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewNavigationController") as? DetailViewNavigationController else {return}
        detailViewNavigationController.modalPresentationStyle = .fullScreen
        DetailViewController.productIdx = productIdx
        presentFromRight()
        present(detailViewNavigationController, animated: false) {
            
        }
    }
    
    
}
