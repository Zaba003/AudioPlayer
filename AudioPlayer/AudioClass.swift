//
//  AudioClass.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 05.09.2021.
//

import Foundation
import AVKit

class AudioClass: NSObject {
    
static let shared = AudioClass()
    
    public var playList = [Track]()
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    func playTrack(previewUrl: String?) {
        print("Пытаюсь включить трек: \(previewUrl ?? "Отсутсвует")")
        guard let url = URL(string: previewUrl ?? "") else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
            player.play()
        }
}





