//
//  UIView.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/26.
//

import UIKit

extension UIView {
    func dottedLine(width: CGFloat, color: CGColor) {
          let caShapeLayer = CAShapeLayer()
          caShapeLayer.strokeColor = color
          caShapeLayer.lineWidth = width
          caShapeLayer.lineDashPattern = [5,2]
          let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: self.frame.height / 2), CGPoint(x: self.frame.width, y: self.frame.height / 2)]
          cgPath.addLines(between: cgPoint)
          caShapeLayer.path = cgPath
          layer.addSublayer(caShapeLayer)
       }
}
