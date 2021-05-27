//
//  ContentView.swift
//  ImageView-SwiftUI
//
//  Created by home on 2021/05/18.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        ImageView(
            url: URL(string: "https://cdn.pixabay.com/photo/2021/04/07/17/13/sea-6159674_960_720.jpg")!,
            cache: cache,
            placeholder: IndicatorView(isAnimating: true)
        )
        .frame(height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
