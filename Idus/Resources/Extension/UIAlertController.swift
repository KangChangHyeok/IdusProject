//
//  UIAlertController.swift
//  Idus
//
//  Created by 강창혁 on 2022/09/07.
//


import UIKit

extension UIAlertController {
    
    func createCheckAlertController(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        return alert
    }
}
