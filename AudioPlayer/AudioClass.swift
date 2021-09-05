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
    
    var playList: [String] = []
    var trackCount: Int = 0
    var trackIndex: Int = 0
    var trackName: String = ""
    var trackUrl: String?
    var currentTime = ""
    
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    func playTrack(url: String?) {
        print("Пытаюсь включить трек: \(url ?? "Отсутсвует")")
        guard let url = URL(string: url ?? "") else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func playPause() {
        if player.timeControlStatus == .paused {
            player.play()
        } else {
            player.pause()
        }
    }
    
    private func getTrack(isForwardTrack: Bool) {
        
    }
    
    /// Переход на следующий трек
    func nextTrack() {
        
    }
    
    /// Переход на предыдущий трек
    func previousTrack() {
        
    }
    
    ///Считаем время (weak self чтобы не допустить утечку памяти)
    private func observeOlayerCurrentTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) {
            [weak self] (time) in self?.currentTime = time.toDisplayString()
            
            /// считаем сколько времени осталось до конца
            let durationTime = self?.player.currentItem?.duration
            let currentDurationText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
        }
    }
}

extension CMTime {
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else {
            return ""
        }
        let totalSecond = Int(CMTimeGetSeconds(self))
        let seconds = totalSecond % 60
        let minuts = totalSecond / 60
        let timeFormatString = String(format: "%02d:%02d", minuts, seconds)
        return timeFormatString
    }
}
