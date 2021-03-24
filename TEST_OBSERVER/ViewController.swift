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
 //   var vc = self()
    
    
    
    
    //private var notificationcenter = NotificationCenter()
    
    
    deinit {
        observationToken?.cancel()
    }
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        //var item = AudioPlayer.Item.init(title: "Nobody wants to be lonely", duration: 5.00)
        //var vc = ViewController()
//        Central.player.addObserver(self)
        
        //notificationcenter = .default
        // Do any additional setup after loading the view.
        
        
        //notificationcenter.addObserver(self, selector: #selector(playbackDidStart), name: .playbackStarted, object: nil)
        
        /*
       observationToken = player.observePlaybackStarted(using: { player, item in
            
            self.titelLabel.text = item.title
            self.durationLabel.text = "\(item.duration)"
        }) */
        
        
        player.addPlaybackStartedObserver(self, closure: {
            
            vc, player, item in
            
            vc.titelLabel.text = item.title
            vc.durationLabel.text = "\(item.duration)"
            
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
