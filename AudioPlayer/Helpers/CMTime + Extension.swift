//
//  CMTime + Extension.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 10.09.2021.
//

import Foundation
import AVKit

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
