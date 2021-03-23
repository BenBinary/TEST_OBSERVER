//
//  File.swift
//  TEST_OBSERVER
//
//  Created by Benedikt Kurz on 23.03.21.
//

import Foundation


protocol AudioPlayerObserver: class {
    
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item)
    
    func audioPlayer(_ player: AudioPlayer, didPausePlaybackOf item: AudioPlayer.Item)
    
    func audioPlayerDidStop(_ player: AudioPlayer)
    
    
}


extension AudioPlayerObserver {
    
    
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item) { }
    
    func audioPlayer(_ player: AudioPlayer, didPausePlaybackOf item: AudioPlayer.Item) { }
    
    func audioPlayerDidStop(_ player: AudioPlayer) { }
    

    
    
}
