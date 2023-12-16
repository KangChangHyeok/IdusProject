//
//  UIViewController.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/05.
//

import UIKit

extension UIViewController {
    
    func presentFromRight() {
        let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
                self.view.window!.layer.add(transition, forKey: nil)
    }
    
    func presentFromLeft() {
        let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
                self.view.window!.layer.add(transition, forKey: nil)
    }
}

