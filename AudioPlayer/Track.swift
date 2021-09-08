//
//  Track.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 06.09.2021.
//

import Foundation

// MARK: - response
struct SearchResponce: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let trackName: String
    let collectionName: String?
    let artistName: String
    let artWorkUrl100: String?
    let previewUrl: String
}

