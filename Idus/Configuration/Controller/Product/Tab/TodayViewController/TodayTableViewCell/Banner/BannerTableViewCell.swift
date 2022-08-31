//
//  BannerTableViewCell.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/03.
//

import UIKit
import FSPagerView
import Kingfisher
class BannerTableViewCell: UITableViewCell {
    
    var getData = DataManager()
    
    //cell에서 사용할 변수
    var bannerCount: Int = 0
    var bannerImages = [String]()
    static let cellId = "BannerTableViewCell"
    static let className = "BannerTableViewCell"
    
    @IBOutlet weak var bannerV: UIView!
    @IBOutlet weak var imagearea: FSPagerView! {
        didSet {
            self.imagearea.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "image")
            self.imagearea.itemSize = FSPagerView.automaticSize
            self.imagearea.isInfinite = true
            self.imagearea.automaticSlidingInterval = 3.0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        print(bannerCount)
        imagearea.dataSource = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension BannerTableViewCell: FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerCount
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = imagearea.dequeueReusableCell(withReuseIdentifier: "image", at: index)
                cell.imageView?.contentMode = .scaleToFill
                cell.imageView?.kf.setImage(with: URL(string: self.bannerImages[index]))
        
        return cell
    }
    
    //    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
    //        self.bannerControl.currentPage = pagerView.currentIndex
    //    }
    
    
}
