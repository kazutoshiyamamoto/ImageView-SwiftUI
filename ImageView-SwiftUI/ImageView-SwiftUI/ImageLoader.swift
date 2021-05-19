//
//  ImageLoader.swift
//  ImageView-SwiftUI
//
//  Created by home on 2021/05/18.
//

import UIKit
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL
    private var cache: ImageCache?
    private var cancellables = Set<AnyCancellable>()
    
    private(set) var isLoading = false
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
        
        // 画像のキャッシュがある場合はimageに代入される
        self.image = cache?[url as AnyObject]
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    private func fetchImage(url: URL) -> Future<UIImage, Never> {
        return Future<UIImage, Never> { promise in
            URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .handleEvents(
                    receiveSubscription: { [weak self] _ in
                        self?.onStart()
                    },
                    receiveCompletion: { [weak self] _ in
                        self?.onFinish()
                    }
                )
                .sink(receiveValue: {
                    promise(.success($0!))
                })
                .store(in: &self.cancellables)
        }
    }
    
    // 画像URLをキーにして画像をキャッシュ
    private func addCache(_ image: UIImage?) {
        image.map { cache?[url as AnyObject] = $0 }
    }
    
    func load() {
        guard !isLoading else { return }
        
        // キャッシュがある場合は通信処理をスキップする
        if cache?[url as AnyObject] != nil { return }
        
        fetchImage(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.image = $0
                self.addCache($0)
            })
            .store(in: &cancellables)
    }
}
