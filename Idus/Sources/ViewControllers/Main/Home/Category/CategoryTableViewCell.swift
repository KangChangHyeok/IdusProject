//
//  CategoryTableViewCell.swift
//  Idus
//
//  Created by 강창혁 on 11/29/23.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell, Reusable {
    
    private lazy var categoryCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: categoryCollectionViewFlowLayout
        )
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            CategoryItemCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryItemCollectionViewCell.reuseIdentifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let categoryImages: [UIImage?] = Array(1...20).map { UIImage(named: "\($0)")}
    private let categoryTexts: [String] = [
        "BEST 선물", "내방꾸미기", "먹거리장터", "패션주얼리샵", "크리스마스", "문방구", "작가냥키우기", "공예",
        "지금할인중", "뷰티", "체험단/이벤트", "idus pick", "크라우드펀딩", "댕냥이슈퍼", "채널d", "우리아이선물", "찐팬분들께", "남성",
        "오프라인숍", "제로웨이스트"
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        Task {
            try await NetworkManager.shared.fetchImages(count:20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(superView: UIView) {
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryCollectionView)
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: (superView.frame.width / 5) * 2)
        ])
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryItemCollectionViewCell
        cell.configure(image: categoryImages[indexPath.row], text: categoryTexts[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryTableViewCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = contentView.frame.width / 5
        return .init(width: itemWidth, height: itemWidth)
    }
}

