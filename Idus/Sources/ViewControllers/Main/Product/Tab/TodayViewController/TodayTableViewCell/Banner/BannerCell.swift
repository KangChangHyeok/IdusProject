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
    
    @IBOutlet weak var bannerV: UIView!
    @IBOutlet weak var imagearea: FSPagerView! {
        didSet {
            imagearea.dataSource = self
            imagearea.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "bannerImage")
            imagearea.itemSize = FSPagerView.automaticSize
            imagearea.isInfinite = true
            imagearea.automaticSlidingInterval = 3.0
        }
    }
    
    static let cellId = "BannerTableViewCell"
    static let className = "BannerTableViewCell"
    var bannerCount: Int = 0
    var bannerImages = [String]()
    
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
        let cell = imagearea.dequeueReusableCell(withReuseIdentifier: "bannerImage", at: index)
                cell.imageView?.contentMode = .scaleToFill
                cell.imageView?.kf.setImage(with: URL(string: self.bannerImages[index]))
        
        return cell
    }
}
