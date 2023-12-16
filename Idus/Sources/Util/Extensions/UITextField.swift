//
//  UITextField.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/27.
//

import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
