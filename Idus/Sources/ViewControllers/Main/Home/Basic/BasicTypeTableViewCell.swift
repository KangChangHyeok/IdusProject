//
//  BasicTypeTableViewCell.swift
//  Idus
//
//  Created by 강창혁 on 12/5/23.
//

import UIKit

final class BasicTypeTableViewCell: UITableViewCell, Reusable {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "붕어빵 주의! 호호 불기만 하세요"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var productCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        return layout
    }()
    
    private lazy var productCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: productCollectionViewFlowLayout
        )
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            BasicTypeCollectionViewCell.self,
            forCellWithReuseIdentifier: BasicTypeCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            BasicTypeCollectionViewFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: BasicTypeCollectionViewFooterView.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var productmoreViewButton: UIButton = {
        var buttonConfig: UIButton.Configuration = .plain()
        buttonConfig.baseBackgroundColor = .white
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        let image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
        buttonConfig.image = image
        buttonConfig.imagePlacement = .trailing
        buttonConfig.imagePadding = 5
        buttonConfig.background.strokeColor = .lightGray
        buttonConfig.background.strokeWidth = 0.5
        buttonConfig.cornerStyle = .capsule
        
        var attributedTitleString = AttributedString("작품 더보기")
        attributedTitleString.foregroundColor = .blue
        attributedTitleString.font = .systemFont(ofSize: 13, weight: .light)
        
        buttonConfig.attributedTitle = attributedTitleString
        
        let button = UIButton(configuration: buttonConfig)
        button.configuration?.cornerStyle = .capsule
        return button
    }()
    
    private var bannerImages: BannerImages? {
        didSet {
            productCollectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        Task {
            self.bannerImages = try await NetworkManager.shared.fetchImages(count: 20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(superView: UIView) {
        contentView.addSubview(titleLabel)
        contentView.addSubview(productCollectionView)
        contentView.addSubview(productmoreViewButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productmoreViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            productCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productCollectionView.heightAnchor.constraint(equalToConstant: ((((superView.frame.width - 40) / 3) + 46) * 2) + 10),
            productmoreViewButton.topAnchor.constraint(equalTo: productCollectionView.bottomAnchor, constant: 5),
            productmoreViewButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productmoreViewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productmoreViewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            productmoreViewButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension BasicTypeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicTypeCollectionViewCell.reuseIdentifier, for: indexPath) as! BasicTypeCollectionViewCell
        guard let imageURL = bannerImages?[indexPath.row].downloadURL else { return UICollectionViewCell() }
        cell.configure(imageURL: imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: BasicTypeCollectionViewFooterView.reuseIdentifier, for: indexPath) as! BasicTypeCollectionViewFooterView
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let itemWidth = (contentView.frame.width - 40) / 3
        return CGSize(width: itemWidth, height: itemWidth + 46)
    }
}

extension BasicTypeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 10)
    }
}

extension BasicTypeTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemWidth = (contentView.frame.width - 40) / 3
        return .init(width: itemWidth, height: itemWidth + 46)
    }
}
