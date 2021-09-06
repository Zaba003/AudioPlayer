//
//  Track.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 06.09.2021.
//

struct Track {
    let artist: String
    let song: String
    let fileName: String
    
    var name: String {
        "\(artist) - \(song)"
    }
}

extension Track {
    static func getTrackList() -> [Track] {
        return [
        Track(artist: "1", song: "1", fileName: "1")
        ]
    }
}
