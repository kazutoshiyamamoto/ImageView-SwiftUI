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

