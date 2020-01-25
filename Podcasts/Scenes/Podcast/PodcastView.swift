//
//  PodcastView.swift
//  Search
//
//  Created by Alberto on 08/06/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct PodcastView: View {

  @ObservedObject var imageLoader: ImageLoader
  @ObservedObject var player: Player

  var viewModel: PodcastViewModel

  init(podcast: Podcast,
       imageLoader: ImageLoader = ImageLoader(),
       player: Player = Container.player) {
    self.viewModel = PodcastViewModel(podcast: podcast)
    self.imageLoader = imageLoader
    self.player = player
  }

  var body: some View {
    VStack {
      List {
        PodcastHeaderView(podcast: viewModel.podcast, imageLoader: imageLoader)
        if viewModel.episodes.isEmpty {
          Spinner()
        } else {
          HStack {
            Spacer()
            Button(action: {
              self.player.setup(for: self.viewModel.episodes)
            }, label: {
              Text("Prepare to play")
            }).foregroundColor(.green)
            Spacer()
          }
          ForEach(viewModel.episodes, id: \.self) { episode in
            NavigationLink(destination: EpisodeView(episode: episode)) {
              EpisodeRow(episode: episode)
            }
          }
        }
      }
      PlayerView()
    }.navigationBarTitle(Text(viewModel.podcast.trackName))
      .onAppear(perform: {
        // TODO: fetch episodes
      })
  }
}

