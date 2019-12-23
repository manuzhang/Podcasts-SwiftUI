//
//  Podcast.swift
//  Podcasts
//
//  Created by Eugene Karambirov on 21/09/2018.
//  Copyright © 2018 Eugene Karambirov. All rights reserved.
//

import Foundation

final class Podcast: NSObject, Decodable, NSCoding, Identifiable {

    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?

    func encode(with aCoder: NSCoder) {
        print("Trying to transform Podcast into Data")
        aCoder.encode(trackName ?? "", forKey: Keys.trackNameKey)
        aCoder.encode(artistName ?? "", forKey: Keys.artistNameKey)
        aCoder.encode(artworkUrl600 ?? "", forKey: Keys.artworkKey)
        aCoder.encode(feedUrl ?? "", forKey: Keys.feedKey)
    }

    init?(coder aDecoder: NSCoder) {
        print("Trying to turn Data into Podcast")
        self.trackName     = aDecoder.decodeObject(forKey: Keys.trackNameKey) as? String
        self.artistName    = aDecoder.decodeObject(forKey: Keys.artistNameKey) as? String
        self.artworkUrl600 = aDecoder.decodeObject(forKey: Keys.artworkKey) as? String
        self.feedUrl       = aDecoder.decodeObject(forKey: Keys.feedKey) as? String
    }

}

private extension Podcast {

    enum Keys {
        static let trackNameKey  = "trackNameKey"
        static let artistNameKey = "artistNameKey"
        static let artworkKey    = "artworkKey"
        static let feedKey       = "feedKey"
    }

}
