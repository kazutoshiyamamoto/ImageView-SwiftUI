//
//  ImageCache.swift
//  ImageView-SwiftUI
//
//  Created by home on 2021/05/18.
//

import UIKit
import SwiftUI

protocol ImageCache {
    var cache: NSCache<AnyObject, UIImage> { get set }
    
    subscript(key: AnyObject) -> UIImage? { get set }
}

struct DefaultImageCache: ImageCache {
    var cache = NSCache<AnyObject, UIImage>()
    
    subscript(key: AnyObject) -> UIImage? {
        get {
            cache.object(forKey: key)
        }
        set(image) {
            cache.setObject(image!, forKey: key)
        }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = DefaultImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get {
            self[ImageCacheKey.self]
        }
        set(image) {
            self[ImageCacheKey.self] = image
        }
    }
}
