//
//  ViewController.swift
//  TEST_OBSERVER
//
//  Created by Benedikt Kurz on 22.03.21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    var player = AudioPlayer()
    private var observationToken: ObservationToken?
    
    
    //private var notificationcenter = NotificationCenter()
    
    
    deinit {
        observationToken?.cancel()
    }
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
//        Central.player.addObserver(self)
        
        //notificationcenter = .default
        // Do any additional setup after loading the view.
        
        
        //notificationcenter.addObserver(self, selector: #selector(playbackDidStart), name: .playbackStarted, object: nil)
        
        
       observationToken = player.observePlaybackStarted(using: { player, item in
            
            self.titelLabel.text = item.title
            self.durationLabel.text = "\(item.duration)"
        })
    }
    
    @IBAction func startPlay(_ sender: UIButton) {
        
        player.play(AudioPlayer.Item.init(title: "Wake me up", duration: 3.55))
    
    }
    
    
    @IBAction func startPlayDrowning(_ sender: Any) {
        
        player.play(AudioPlayer.Item.init(title: "Drowning", duration: 4.55))
        
    }
    
    @IBAction func startPlayHoldtheline(_ sender: UIButton) {
        
        player.play(AudioPlayer.Item.init(title: "Hold the line", duration: 5.25))
        
    }
    
    
}

/**
    Notifies our part
 */
/*
extension ViewController: AudioPlayerObserver {
    
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item) {
        titelLabel.text = item.title
        durationLabel.text = "\(item.duration)"
    }
    
} */
