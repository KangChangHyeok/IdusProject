//
//  UITabBarController.swift
//  Idus
//
//  Created by 강창혁 on 12/16/23.
//

import UIKit

extension UITabBarController {
    
    func configureTabBarItem(
        title: String,
        unselectedImage: String,
        selectedImage: String
    ) -> UITabBarItem {
        let tabBarItem = UITabBarItem(
            title: title,
            image: .init(systemName: unselectedImage),
            selectedImage: .init(systemName: selectedImage)
        )
        return tabBarItem
    }
    
}
