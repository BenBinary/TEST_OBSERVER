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
   // var player = AudioPlayer()
    
    
    //private var notificationcenter = NotificationCenter()
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        Central.player.addObserver(self)
        
        //notificationcenter = .default
        // Do any additional setup after loading the view.
        
        
        //notificationcenter.addObserver(self, selector: #selector(playbackDidStart), name: .playbackStarted, object: nil)
    }
    
    @IBAction func startPlay(_ sender: UIButton) {
        
        Central.player.play(AudioPlayer.Item.init(title: "Wake me up", duration: 3.55))
    
    }
    
    
    @IBAction func startPlayDrowning(_ sender: Any) {
        
        Central.player.play(AudioPlayer.Item.init(title: "Drowning", duration: 4.55))
        
    }
    
}

/**
    Notifies our part
 */
extension ViewController: AudioPlayerObserver {
    
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item) {
        titelLabel.text = item.title
        durationLabel.text = "\(item.duration)"
    }
    
}
