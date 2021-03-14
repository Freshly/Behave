//
//  Behave+Performance.swift
//  Behave
//
//  Created by Derek Bronston on 3/9/21.
//

import Foundation

public extension Behaviour {
   
    /// Sets up test. Resets start and end values. Then sets start to current timestamp.
    /// - Parameters:
    ///   - frames: the number of frames displayed in this view
    /// - Returns: Bool
    func setUpPerformanceTest() {
        reset()
        start = NSDate().timeIntervalSince1970
    }
    
    /// Measures performance based on time in relation for FPS. Given that one frame is displayed in 16.67ms at 60 fps. Then the Number of frames * 16.67 shouldl be the total time it takes to display the frames in question.
    /// - Parameters:
    ///   - frames: the number of frames displayed in this view
    /// - Returns: Bool
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
