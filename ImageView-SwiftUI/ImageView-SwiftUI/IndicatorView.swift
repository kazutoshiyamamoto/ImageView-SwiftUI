//
//  IndicatorView.swift
//  ImageView-SwiftUI
//
//  Created by home on 2021/05/19.
//

import SwiftUI

struct IndicatorView: UIViewRepresentable {
    let isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }
    
    func updateUIView(_ indicatorView: UIActivityIndicatorView, context: Context) {
        isAnimating ? indicatorView.startAnimating() : indicatorView.stopAnimating()
    }
}
