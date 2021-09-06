//
//  TrackDetailsViewController.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 07.09.2021.
//

import UIKit

class TrackDetailsViewController: UIViewController {

    @IBOutlet var artCoverImageView: UIImageView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var durationTimeLabel: UILabel!
    
    var track: Track!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func prevButton(_ sender: Any) {
    }
    @IBAction func nextButton(_ sender: Any) {
    }
    @IBAction func playPauseButton(_ sender: Any) {
    }
}
