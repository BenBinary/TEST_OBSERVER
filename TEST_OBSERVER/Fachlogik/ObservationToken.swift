//
//  ObservationToken.swift
//  TEST_OBSERVER
//
//  Created by Benedikt Kurz on 24.03.21.
//

import Foundation

/**
    
        To unregister an object for being an observer
 
 */
class ObservationToken {
    
    private let cancellationClosure: () -> Void
    
    init(cancellationClosure: @escaping () -> Void) {
        
        self.cancellationClosure = cancellationClosure
        
    }
    
    func cancel() {
        cancellationClosure()
    }
    
}



