//
//  Track.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 06.09.2021.
//

import Foundation

// MARK: - response
struct SearchResponce: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
    var previewUrl: String?
}

