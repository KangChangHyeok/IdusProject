//
//  BannerCell.swift
//  Idus
//
//  Created by 강창혁 on 2023/11/28.
//

import UIKit

final class BannerCell: UITableViewCell, Reusable {
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    private lazy var bannerItemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewFlowLayout
        )
        
        collectionView.register(
            BannerCollectionViewCell.self,
            forCellWithReuseIdentifier: BannerCollectionViewCell.reuseIdentifier
        )
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let pageView: PageView = {
        let view = PageView()
        return view
    }()
    
    private var bannerImages: BannerImages? {
        didSet {
            bannerItemCollectionView.reloadData()
        }
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        Task {
            self.bannerImages = try await NetworkManager.shared.fetchImages(count:10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

private extension BannerCell {
    
    func setupUI() {
        setupBannerCollectionView()
        setupPageView()
    }
    
    func setupBannerCollectionView() {
        bannerItemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bannerItemCollectionView)
        NSLayoutConstraint.activate([
            bannerItemCollectionView.heightAnchor.constraint(equalToConstant: 200),
            bannerItemCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerItemCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerItemCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerItemCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    func setupPageView() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageView)
        
        NSLayoutConstraint.activate([
            pageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension BannerCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        cell.configure(imageURLString: bannerImages?[indexPath.row].downloadURL)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension BannerCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageView.currentPageNumberLabel.text = "\(indexPath.row + 1)"
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BannerCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: contentView.frame.width, height: 200)
    }
}
