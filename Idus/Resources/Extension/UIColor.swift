//
//  UIColor.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit


extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    convenience init(rgb: CGFloat) {
        self.init(red: rgb/255, green: rgb/255, blue: rgb/255, alpha: 1)
    }
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
    class var idusMainColor: UIColor {UIColor(hex: 0xef8345)}
    class var kakaoFontColor: UIColor {UIColor(hex: 0x3A1D1D)}
    class var LoginViewImageBackgroundColor: UIColor {UIColor(hex: 0xf7f6f4)}
    class var kakaoYellowColor: UIColor {UIColor(hex: 0xF7E600)}
    class var lightGray: UIColor {UIColor(hex: 0xD9D9D9)}
}

