//
//  BViewController.swift
//  Idus
//
//  Created by 강창혁 on 2023/11/03.
//

import UIKit

final class FoodViewController: UIViewController {
    
    enum SectionLayout: Int, CaseIterable {
        case banner
        case bannerCategory
        case grid
        case list
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.delegate = self
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<SectionLayout, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureDataSource()
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, environment in
            guard let layout = SectionLayout(rawValue: section) else { fatalError() }
            switch layout {
            case .banner:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(1.0)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                return section
            case .bannerCategory:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3)
                    , heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(50)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .grid:
                // top
                let topLeadingItemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0)
                )
                let topLeadingItem = NSCollectionLayoutItem(layoutSize: topLeadingItemSize)
                
                let topTrailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/2))
                let topTrailingItem = NSCollectionLayoutItem(layoutSize: topTrailingItemSize)
                
                let topTrailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
                let topTrailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: topTrailingGroupSize, repeatingSubitem: topTrailingItem, count: 2)
                topTrailingGroup.interItemSpacing = .fixed(10)
                let topGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/3))
                let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topGroupSize, subitems: [topLeadingItem, topTrailingGroup])
                topGroup.interItemSpacing = .fixed(10)
                topGroup.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                // bottom
                let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
                let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
                
                let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
                let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, repeatingSubitem: bottomItem, count: 3)
                bottomGroup.interItemSpacing = .fixed(10)
                bottomGroup.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [topGroup, bottomGroup])
                group.interItemSpacing = .fixed(10)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: "SectionHeader", alignment: .topLeading)
                
                let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize, elementKind: "SectionFooter", alignment: .bottom)
                section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
                return section
            case .list:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width / 3 - 10), heightDimension: .fractionalHeight(1))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                let outerGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .absolute((self.view.frame.width / 3 + 50) * 2))
                let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [group])
                let section = NSCollectionLayoutSection(group: outerGroup)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        return layout
    }
    
    func configureLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        
        // Banner
        
        let bannerCellRegisteration = UICollectionView.CellRegistration<BannerCVCell, Int> { cell, indexPath, int in
            print(indexPath)
        }
        let bannerCategoryCellRegisteration = UICollectionView.CellRegistration<BannerCategoryCell, Int> { cell, indexPath, itemIdentifier in
            print(indexPath)
        }
        
        //grid
        
        let gridHeaderRegisteration = UICollectionView.SupplementaryRegistration<SectionHeaderView>(elementKind: "SectionHeader") { supplementaryView, elementKind, indexPath in
            supplementaryView.titleLabel.text = "grid Section Header Title"
            supplementaryView.titleLabel.textColor = .black
        }
        let gridCellRegisteration = UICollectionView.CellRegistration<GridCell, Int> { cell, indexPath, itemIdentifier in
            print(indexPath)
        }
        let gridFooterRegisteration = UICollectionView.SupplementaryRegistration<GridSectionFooterView>(elementKind: "SectionFooter") { supplementaryView, elementKind, indexPath in
            supplementaryView.pageControl.numberOfPages = 5
            supplementaryView.pageControl.currentPage = 0
            supplementaryView.pageControl.currentPageIndicatorTintColor = .black
            supplementaryView.pageControl.pageIndicatorTintColor = .gray
        }
        
        // list
        
        let listCellRegistaration = UICollectionView.CellRegistration<ListCVCell, Int> { cell, indexPath, itemIdentifier in
            print(indexPath)
        }
        
        dataSource = UICollectionViewDiffableDataSource<SectionLayout, Int>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let section = SectionLayout(rawValue: indexPath.section) else { return UICollectionViewCell() }
            
            switch section {
            case .banner:
                return collectionView.dequeueConfiguredReusableCell(using: bannerCellRegisteration, for: indexPath, item: itemIdentifier)
            case .bannerCategory:
                return collectionView.dequeueConfiguredReusableCell(using: bannerCategoryCellRegisteration, for: indexPath, item: itemIdentifier)
            case .grid:
                return collectionView.dequeueConfiguredReusableCell(using: gridCellRegisteration, for: indexPath, item: itemIdentifier)
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistaration, for: indexPath, item: itemIdentifier)
            }
        }
        
        dataSource.supplementaryViewProvider = { view, kind, index in
            if kind == "SectionHeader" {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: gridHeaderRegisteration, for: index)
            } else {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: gridFooterRegisteration, for: index)
            }
        }
        
        var snapShot = NSDiffableDataSourceSnapshot<SectionLayout, Int>()
        
        SectionLayout.allCases.forEach { section in
            snapShot.appendSections([section])
            switch section {
            case .banner:
                snapShot.appendItems(Array(1...10))
            case .bannerCategory:
                snapShot.appendItems(Array(11...19))
            case .grid:
                snapShot.appendItems(Array(30...59))
            case .list:
                snapShot.appendItems(Array(60...79))
            }
        }
        dataSource.apply(snapShot)
    }
}

extension FoodViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let section = SectionLayout(rawValue: indexPath.section) else { return }
        guard case .bannerCategory = section else { return }
        
        let sectionItemCount = dataSource.collectionView(collectionView, numberOfItemsInSection: section.rawValue)
        
        guard indexPath.row == sectionItemCount - 1 else { return }
        var snapShot = dataSource.snapshot()
        
        snapShot.insertItems(Array(20...27), afterItem: 19)
        dataSource.apply(snapShot)
    }
}
