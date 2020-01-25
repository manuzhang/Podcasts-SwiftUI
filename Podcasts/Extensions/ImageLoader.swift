//
//  ImageLoader.swift
//  Search
//
//  Created by Alberto on 10/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import UIKit.UIImage
import SwiftUI
import Combine
import class Kingfisher.ImageDownloader
import struct Kingfisher.DownloadTask
import class Kingfisher.ImageCache
import class Kingfisher.KingfisherManager

class ImageLoader: ObservableObject {

  var didChange = PassthroughSubject<ImageLoader, Never>()
  private let downloader: ImageDownloader
  private let cache: ImageCache
  private var image: UIImage? {
    didSet {
      dispatchqueue.async { [weak self] in
        guard let self = self else {
          return
        }
        self.didChange.send(self)
      }
    }
  }
  private var task: DownloadTask?
  private let dispatchqueue: DispatchQueue

  init(downloader: ImageDownloader = KingfisherManager.shared.downloader,
       cache: ImageCache = KingfisherManager.shared.cache,
       dispatchqueue: DispatchQueue = DispatchQueue.main) {
    self.downloader = downloader
    self.cache = cache
    self.dispatchqueue = dispatchqueue
  }

  deinit {
    task?.cancel()
  }

  func image(for url: URL?) -> UIImage {
    guard let targetUrl = url else {
      return UIImage.from(color: .gray)
    }
    guard let image = image else {
      load(url: targetUrl)
      return UIImage.from(color: .gray)
    }
    return image
  }

  private func load(url: URL) {
    let key = url.absoluteString
    if cache.isCached(forKey: key) {
      cache.retrieveImage(forKey: key) { [weak self] (result) in
        guard let self = self else {
          return
        }
        switch result {
        case .success(let value):
          self.image = value.image
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    } else {
      downloader.downloadImage(with: url, options: nil, progressBlock: nil) { [weak self] (result) in
        guard let self = self else {
          return
        }
        switch result {
        case .success(let value):
          self.cache.storeToDisk(value.originalData, forKey: url.absoluteString)
          self.image = value.image
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }

}
