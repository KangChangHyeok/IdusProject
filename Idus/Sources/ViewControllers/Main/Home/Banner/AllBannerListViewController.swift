//
//  AllBannerListViewController.swift
//  Idus
//
//  Created by 강창혁 on 12/19/23.
//

import UIKit

final class AllBannerListViewController: BaseViewController {
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.dismissButton.addAction(headerViewDismissButtonAction, for: .touchUpInside)
        return view
    }()
    
    private lazy var headerViewDismissButtonAction: UIAction = UIAction { [weak self] _ in
        self?.dismiss(animated: true)
    }
    
    private lazy var bannerTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseIdentifier)
        return tableView
    }()
    
    private var bannerImages: BannerImages? {
        didSet {
            bannerTableView.reloadData()
            headerView.bind(count: bannerImages?.count ?? 0)
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBannerImages()
    }
    
    func fetchBannerImages() {
        Task {
            let bannerImages = try await NetworkManager.shared.fetchImages(count:10)
            self.bannerImages = bannerImages
        }
    }
    
    override func configureUI() {
        configureHeaderViewConstraints()
        configureTableViewConstraints()
    }
    
    func configureHeaderViewConstraints() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureTableViewConstraints() {
        view.addSubview(bannerTableView)
        bannerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5),
            bannerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AllBannerListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bannerImages?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ImageCell.reuseIdentifier,
            for: indexPath
        ) as! ImageCell
        cell.bind(imageURLString: bannerImages?[indexPath.row].downloadURL)
        return cell
    }
}
