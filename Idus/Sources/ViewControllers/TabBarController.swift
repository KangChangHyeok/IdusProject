//
//  ViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/25.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaults()
        configureTabBarItems()
    }
    
    func configureDefaults() {
        self.tabBar.tintColor = .idusmainColor
        self.view.backgroundColor = .white
    }
    
    func configureTabBarItems() {
        tabBar.backgroundColor = .white
        let mainViewController = MainViewController()
        mainViewController.tabBarItem = configureTabBarItem(
            title: "작품홈",
            unselectedImage: "house",
            selectedImage: "house.fill"
        )
        let myInformationViewController = MyInfomationViewController()
        myInformationViewController.tabBarItem = configureTabBarItem(
            title: "내 정보",
            unselectedImage: "person",
            selectedImage: "person.fill"
        )
        self.viewControllers = [mainViewController, myInformationViewController]
    }
}

