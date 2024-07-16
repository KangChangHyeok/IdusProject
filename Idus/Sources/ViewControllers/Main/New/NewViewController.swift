//
//  CViewController.swift
//  Idus
//
//  Created by 강창혁 on 2023/11/03.
//

import UIKit

final class NewViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collectionView.backgroundColor = .black
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDiffableDataSource()
        apply()
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureDiffableDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<NewItemCVCell, Int> { cell, indexPath, int in
            cell.configure(index: indexPath.row)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int> (collectionView: self.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    private func apply() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapShot.appendSections([1])
        snapShot.appendItems(Array(1...20))
        dataSource.apply(snapShot)
    }
}
