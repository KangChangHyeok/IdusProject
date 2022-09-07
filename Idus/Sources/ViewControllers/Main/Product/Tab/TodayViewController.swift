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

class TodayViewController: UIViewController {
    
    //MARK: - IBOutlet, property
    
    @IBOutlet weak var todayTableView: UITableView! {
        didSet {
            todayTableView.dataSource = self
            todayTableView.register(UINib(nibName: BannerCell.className, bundle: nil), forCellReuseIdentifier: BannerCell.cellId)
            todayTableView.register(UINib(nibName: MenuCell.className, bundle: nil), forCellReuseIdentifier: MenuCell.cellId)
            todayTableView.register(UINib(nibName: CategoryCell.className, bundle: nil), forCellReuseIdentifier: CategoryCell.cellId)
        }
    }
    
    let dataManager = DataManager()
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - extension

extension TodayViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 3
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.cellId, for: indexPath) as! BannerCell
            self.dataManager.getTodayProductData { TodayProductData in
                cell.bannerCount = TodayProductData.result.banners.count
                cell.bannerImages = TodayProductData.result.banners
                cell.banner.reloadData()
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellId, for: indexPath) as! MenuCell
            return cell
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.cellId, for: indexPath) as! CategoryCell
                cell.delegate = self
                
                self.dataManager.getTodayProductData { TodayProductData in
                    cell.products = TodayProductData.result.category1
                    cell.categoryName.text = "달달한 디저트 모음"
                    cell.CategoryCellCollectionView.reloadData()
                }
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.cellId, for: indexPath) as! CategoryCell
                cell.delegate = self
                
                self.dataManager.getTodayProductData { TodayProductData in
                    cell.products = TodayProductData.result.category2
                    cell.categoryName.text = "커피 없인 못 살아..."
                    cell.CategoryCellCollectionView.reloadData()
                }
                return cell
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.cellId, for: indexPath) as! CategoryCell
                cell.delegate = self
                
                self.dataManager.getTodayProductData { TodayProductData in
                    cell.products = TodayProductData.result.category3
                    cell.categoryName.text = "여러가지 주류 모음"
                    cell.CategoryCellCollectionView.reloadData()
                }
                return cell
                
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    
}

//MARK: - extension

extension TodayViewController: CollectionViewCellDelegate {
    func selectedCell(_ productIdx: Int) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        DetailViewController.productIdx = productIdx
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

