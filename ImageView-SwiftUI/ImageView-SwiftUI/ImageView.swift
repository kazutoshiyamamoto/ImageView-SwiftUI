//
//  ImageView.swift
//  ImageView-SwiftUI
//
//  Created by home on 2021/05/18.
//

import SwiftUI

struct ImageView<Placeholder: View>: View {
    @ObservedObject private var imageloader: ImageLoader
    private let placeholder: Placeholder?
    
    init(url: URL, cache: ImageCache? = nil, placeholder: Placeholder? = nil) {
        imageloader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if imageloader.image != nil {
                Image(uiImage: imageloader.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
            }
        }
        .onAppear(perform: imageloader.load)
    }
}
