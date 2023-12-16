//
//  UIImageView.swift
//  Idus
//
//  Created by 강창혁 on 12/7/23.
//

import UIKit

extension UIImageView {
    //성능상 UIGraphicsImageRenderer보다 더 좋다고 하는데, 현재 사용 API에서 다운샘플링 실패해서 미사용.
    func setDownSamplingImage(url: URL) {
        let size = self.bounds.size
        let scale = UIScreen.main.scale
        let imageCacheKey = url.absoluteString as NSString
        // 캐싱된 이미지가 있다면 해당 이미지를 할당후 종료
        if let cachedImage = ImageCacheManager.shared.object(forKey: imageCacheKey) {
            self.image = cachedImage
            return
        }
        // 캐싱된 이미지가 없다면 url을 통해 이미지 가져오기
        DispatchQueue.global().async { [weak self] in
            // 가져올때는 해당 imageView의 화면에 맞추어 다운샘플링후 가져오기
            guard let imageData = try? Data(contentsOf: url) else { return }
            guard let image = self?.downsampleImage(at: imageData, to: size, scale: scale) else { return }
            ImageCacheManager.shared.setObject(image, forKey: imageCacheKey)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    /// url을 통한 Image DownSampling
    func downSample(at url: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, imageSourceOptions) else {
            return nil
        }
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        
        return UIImage(cgImage: downsampledImage)
    }
    
    /// Data를 통한 Image DownSampling
    func downsampleImage(at imageData: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else { return nil }
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            print("CGImageSourceCreateThumbnailAtIndex error")
            return nil
        }
        return UIImage(cgImage: downsampledImage)
    }
    
    ///UIGraphicsImageRenderer를 사용하여 이미지를 렌더링 후. 캐싱하여 이미지 사용
    func setImage(url: URL) {
        let imageCacheKey = url.absoluteString as NSString
        // 캐싱된 이미지가 있다면 해당 이미지를 할당후 종료
        if let cachedImage = ImageCacheManager.shared.object(forKey: imageCacheKey) {
            self.image = cachedImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            let image = url.fetchUIImage()
            DispatchQueue.main.async {
                self?.downSample(image: image, cacheKey: imageCacheKey)
            }
        }
    }
    
    func downSample(image: UIImage?, cacheKey: NSString) {
        guard let image else { return }
        let render = UIGraphicsImageRenderer(size: self.frame.size)
        let renderImage = render.image { context in
            image.draw(in: self.frame)
        }
        //rendering 된 이미지를 cache에 저장.
        ImageCacheManager.shared.setObject(renderImage, forKey: cacheKey)
        self.image = renderImage
    }
}
