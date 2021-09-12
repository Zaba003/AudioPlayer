//
//  UserDefault.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 12.09.2021.
//

import Foundation

extension UserDefaults {
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        
        guard let savedTracks = defaults.object(forKey: UserDefaults.favouriteTrackKey) as? Data else {
            return []
        }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else {
            return [] }
        return decodedTracks
        }
    }

