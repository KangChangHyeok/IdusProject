//
//  ProductViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/30.
//

import UIKit
import Tabman
import Pageboy
import Then

class ProductViewController: TabmanViewController {
    
    //MARK: - IBOutlet, property
    
    private var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        let todayVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TodayViewController") as! TodayViewController
        let realTimeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RealTimeViewController") as! RealTimeViewController
        let newVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
        viewControllers.append(todayVC)
        viewControllers.append(realTimeVC)
        viewControllers.append(newVC)
        return viewControllers
    }()
    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "추석 연휴 할인을 검색해보세요."
        $0.searchTextField.font = UIFont.systemFont(ofSize: 14)
        $0.tintColor = UIColor(red: 206, green: 206, blue: 206)
        $0.searchTextField.backgroundColor = .systemBackground
        $0.searchTextField.layer.borderWidth = 1
        $0.searchTextField.layer.borderColor = UIColor(red: 206, green: 206, blue: 206).cgColor
        $0.searchTextField.layer.cornerRadius = 4
        $0.searchTextField.leftView = .none
        $0.searchTextField.leftViewMode = .never
    }
    private var idusLogo = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "idusLogoImage.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    private lazy var leftBarButtonItem = UIBarButtonItem(customView: idusLogo).then {
        $0.customView?.translatesAutoresizingMaskIntoConstraints = false
        $0.customView?.heightAnchor.constraint(equalToConstant: (self.navigationController?.navigationBar.frame.height)! / 1.7).isActive = true
        $0.customView?.widthAnchor.constraint(equalToConstant: self.view.frame.width / 7).isActive = true
    }
    private var tabBar = TMBar.ButtonBar().then {
        //TMBarView
        $0.backgroundView.style = .clear
        //TMBarLayout
        $0.layout.contentMode = .fit
        //TMBarButton
        $0.buttons.customize { button in
            button.tintColor = .lightGray
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        //TMBarindicator
        $0.indicator.backgroundColor = .black
        $0.indicator.transitionStyle = .none
        $0.indicator.weight = .medium
    }
    
    //MARK: - override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValue()
    }
    
    //MARK: - setupValue
    
    func setupValue() {
        self.dataSource = self
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.titleView = searchBar
        self.searchBar.searchTextField.rightView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        self.searchBar.searchTextField.rightViewMode = .always
        self.addBar(tabBar, dataSource: self, at: .top)
    }
}

extension ProductViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "투데이")
        case 1:
            return TMBarItem(title: "실시간")
        case 2:
            return TMBarItem(title: "New")
        default:
            let title = "Page\(index)"
            return TMBarItem(title: title)
        }
    }
}
