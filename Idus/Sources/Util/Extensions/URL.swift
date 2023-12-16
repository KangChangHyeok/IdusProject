//
//  URL.swift
//  Idus
//
//  Created by 강창혁 on 12/16/23.
//

import UIKit

extension URL {
    
    func fetchUIImage() -> UIImage? {
        guard let data = try? Data(contentsOf: self) else {
            print("Data로 변환 안됨")
            return nil
        }
        guard let image = UIImage(data: data) else {
            print("UIImage 생성 실패")
            return nil
        }
        return image
    }
}
