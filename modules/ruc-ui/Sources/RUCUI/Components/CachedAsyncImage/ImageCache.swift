//
//  ImageCache.swift
//  RUCUI
//

import UIKit

actor ImageCache {

    // MARK: Internal

    static let shared = ImageCache()

    func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }

    func insert(_ image: UIImage, for url: URL) {
        let cost = image.jpegData(compressionQuality: 1)?.count ?? 0
        cache.setObject(image, forKey: url as NSURL, cost: cost)
    }

    // MARK: Private

    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 50 * 1024 * 1024 // 50 MB
        return cache
    }()

}
