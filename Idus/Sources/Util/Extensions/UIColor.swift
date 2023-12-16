//
//  UIColor.swift
//  Ideas
//
//  Created by 강창혁 on 2022/07/04.
//

import UIKit


extension UIColor {
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
    class var idusmainColor: UIColor {UIColor(hex: 0xef8345)}
    class var kakaofont: UIColor {UIColor(hex: 0x3A1D1D)}
    class var splashPVCColor: UIColor {UIColor(hex: 0xf7f6f4)}
    class var kakaoyellow: UIColor {UIColor(hex: 0xF7E600)}
    class var lightGray: UIColor {UIColor(hex: 0xD9D9D9)}
    
    //MARK: 랜덤 컬러 색상 얻기
    static var randomColor: UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    
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
}

