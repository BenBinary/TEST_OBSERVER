//
//  ViewControllerDetail.swift
//  TEST_OBSERVER
//
//  Created by Benedikt Kurz on 23.03.21.
//

import UIKit

class ViewControllerDetail: UIViewController {
    
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    //var player2 = AudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // Central.player.addObserver(self)
    }
    
    
    @IBAction func start(_ sender: UIButton) {
        
        Central.player.play(AudioPlayer.Item.init(title: "Street Dancer", duration: 5.55))
        
        print("Start VC-Detail")
        
    }
    

}


extension ViewControllerDetail: AudioPlayerObserver {
    
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item) {
        
        print("AudioPlayerOberserver ")
        
        lblTitel.text = item.title
        lblDuration.text = "\(item.duration)"
        
    }
    
}
