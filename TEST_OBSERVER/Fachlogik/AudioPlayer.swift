//
//  AudioPlayer.swift
//  TEST_OBSERVER
//
//  Created by Benedikt Kurz on 22.03.21.
//

import Foundation

class AudioPlayer {
    
    class Item  {
        
        internal init(title: String, duration: Double) {
            self.title = title
            self.duration = duration
        }
        
        var title: String
        var duration: Double
        
    }
    
    
    // private let notificationcenter: NotificationCenter
    private var observations = [ObjectIdentifier : Observation]()
    //  public let item = Item()
    
    /*
     init(notificationCenter: NotificationCenter = .default) {
     self.notificationcenter = notificationCenter
     } */
    
    private var state = State.idle {
        
        didSet {
            stateDidChange()
        }
        
    }
    
    func play(_ item: Item)  {
        state = State.playing(item)
    }
    
    func pause() {
        
        switch state {
        
        case .idle, .paused:
            break
        case .playing(let item):
            state = .paused(item)
        //pausePlayback()
        
        }
        
    }
    
    func stop()  {
        
        state = .idle
        //stopPlayback()
        
    }
    
}

/**
 To Add and remove Observer
 */
extension AudioPlayer {
    
    func addObserver(_ observer: AudioPlayerObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    func removeObserver(_ observer: AudioPlayerObserver) {
        
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
        
    }
    
}

private extension AudioPlayer {
    
    struct Observation {
        weak var observer: AudioPlayerObserver?
    }
    
    
    func stateDidChange() {
        
        for (id, observation) in observations {
            
            
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }
            
            switch state {
            
            case .idle:
                observer.audioPlayerDidStop(self)
                
            case .playing(let item):
                observer.audioPlayer(self, didStartPlaying: item)
            //notificationcenter.post(name: .playbackStarted, object: item )
            
            case .paused(let item):
                observer.audioPlayer(self, didPausePlaybackOf: item)
            //notificationcenter.post(name: .playbackPaused, object: item)
            
            
            }
            
        }
        
    }
    
    enum State {
        
        case idle
        case playing(Item)
        case paused(Item)
        
    }
}
