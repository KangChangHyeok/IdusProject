//
//  BannerTableViewCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/03.
//

import UIKit
import FSPagerView
import Kingfisher

class BannerCell: UITableViewCell {
    
    //MARK: - IBOutlet, property
    
    @IBOutlet weak var banner: FSPagerView! {
        didSet {
            banner.dataSource = self
            banner.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "bannerImage")
            banner.itemSize = FSPagerView.automaticSize
            banner.automaticSlidingInterval = 3.0
        }
    }
    
    static let cellId = "BannerCell"
    static let className = "BannerCell"
    var bannerCount: Int = 0
    var bannerImages = [Banner]()
    
    //MARK: - override Method
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - extension

extension BannerCell: FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerCount
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = banner.dequeueReusableCell(withReuseIdentifier: "bannerImage", at: index)
                cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.kf.setImage(with: URL(string: self.bannerImages[index].bannerImageURL))
        return cell
    }
}
