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
    // private var observations = [ObjectIdentifier : Observation]()
    
    private var observations = (started: [UUID: (AudioPlayer, Item) -> Void](),
                                paused: [UUID: (AudioPlayer, Item) -> Void](),
                                stopped: [UUID: (AudioPlayer) -> Void]())
    
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
/*
extension AudioPlayer {
    
    func addObserver(_ observer: AudioPlayerObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    func removeObserver(_ observer: AudioPlayerObserver) {
        
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
        
    }
    
} */


extension AudioPlayer {
    
    
    // Zum Starten des Observers
    @discardableResult
    func observePlaybackStarted(using closure: @escaping (AudioPlayer, Item) -> Void) -> ObservationToken {
        
        let id = observations.started.insert(closure)
        return ObservationToken { [weak self] in self?.observations.started.removeValue(forKey: id) }
        
    }
    
    @discardableResult
    func observePlaybackPaused(using closure: @escaping (AudioPlayer, Item) -> Void) -> ObservationToken {
       
        let id = observations.paused.insert(closure)
        return ObservationToken { [weak self] in self?.observations.paused.removeValue(forKey: id) }
        
    }
    
    @discardableResult
    func observePlaybackStopped(using closure: @escaping (AudioPlayer) -> Void) -> ObservationToken {
        
        let id = observations.stopped.insert(closure)
        return ObservationToken { [weak self] in self?.observations.stopped.removeValue(forKey: id) }
        
    }
    
}

private extension AudioPlayer {
    
    struct Observation {
        weak var observer: AudioPlayerObserver?
    }
    
    
    func stateDidChange() {
 
            switch state {
            
            case .idle:
                observations.stopped.values.forEach { closure in closure(self) }
                
            case .playing(let item):
                observations.started.values.forEach { closure in closure(self, item) }
                
            case .paused(let item):
                observations.paused.values.forEach { closure in closure(self, item) }
            }
            
        
    }
    
    enum State {
        
        case idle
        case playing(Item)
        case paused(Item)
        
    }
}


/// Extension to assign dedicated UUIDs
private extension Dictionary where Key == UUID {
    
    mutating func insert(_ value: Value) -> UUID {
        
        let id = UUID()
        self[id] = value
        return id
        
    }
    
}
