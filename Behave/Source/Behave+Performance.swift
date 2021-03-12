//
//  Behave+Performance.swift
//  Behave
//
//  Created by Derek Bronston on 3/9/21.
//

import Foundation

public extension Behaviour {
   
    func setUpPerformanceTest() {
        reset()
        start = NSDate().timeIntervalSince1970
    }
    
    func measurePerformance(frames: Int) -> Bool {
        mark()
        let renderTime = (16.67 * Double(frames))
        let frameTime = ((end - start) * 1000.0)
        if frameTime <= renderTime {
            return true
        }
        return false
    }
    
    private func reset() {
        start = 0.0
        end = 0.0
    }
    
    private func mark() {
        end = NSDate().timeIntervalSince1970
    }
}
