//
//  PodcastRow.swift
//  Podcasts
//
//  Created by Alberto on 08/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct PodcastRow : View {
    
    @ObservedObject var imageLoader: ImageLoader
    let podcast: Podcast
    
    init(imageLoader: ImageLoader = ImageLoader(),
         podcast: Podcast) {
        self.imageLoader = imageLoader
        self.podcast = podcast
    }
    
    var body: some View {
        HStack {
/*            Image(uiImage: self.imageLoader.image(for: self.podcast.thumbnail))
                .frame(width: 64, height: 64, alignment: .center)
                .aspectRatio(contentMode: ContentMode.fit)
                .clipShape(Circle())*/
            VStack(alignment: .leading) {
                Text(podcast.trackName)
                    .lineLimit(nil)
                    .font(.headline)
/*                Text(podcast.language)
                    .lineLimit(1)
                    .font(.caption)*/
            }
        }
    }
}