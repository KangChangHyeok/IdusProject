//
//  ImageCacheManager.swift
//  Idus
//
//  Created by 강창혁 on 12/15/23.
//

import UIKit

final class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
    
}
