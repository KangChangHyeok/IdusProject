//
//  AViewController.swift
//  Idus
//
//  Created by 강창혁 on 2023/11/03.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private lazy var homeTableView: UITableView = {
        let tableview = UITableView()
        tableview.showsVerticalScrollIndicator = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseIdentifier)
        tableview.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableview.register(BasicTypeTableViewCell.self, forCellReuseIdentifier: BasicTypeTableViewCell.reuseIdentifier)
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 200
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(homeTableView)
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as! BannerCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
            cell.configureUI(superView: view)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: BasicTypeTableViewCell.reuseIdentifier, for: indexPath) as! BasicTypeTableViewCell
            cell.configureUI(superView: view)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
}


