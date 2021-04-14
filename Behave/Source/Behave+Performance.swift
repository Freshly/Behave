//
//  Behave+Performance.swift
//  Behave
//
//  Created by Derek Bronston on 3/9/21.
//

import Foundation
import Metal

public extension Behaviour {
    
    /// Measures performance based on time in relation for FPS. Given that one frame is displayed in 16.67ms at 60 fps. This inititates the test process. Resest start, end and passesPerformanceTest for tracking and enables the CADisplayLink API. 
    func measurePerformance(){
        reset()
        let displaylink = CADisplayLink(target: self,
                                        selector: #selector(step))
        displaylink.add(to: .current,
                        forMode: .default)
    }
    
    /// THIS IS CALLED ON EACH FRAME RENDERING PER THE CADisplayLink callback. It checks each frame render and calculates the time based on the returned timestamp. If the frame is rendered in more than 16.67ms it markes it as failing the performnace test.
    @objc private func step(displaylink: CADisplayLink) {
        if start == 0.0 {
            start = displaylink.timestamp
        } else {
            end = displaylink.timestamp
            if (end - start) > 0.0167 {
                passesPerformanceTest = false
            }
            start = displaylink.timestamp
        }
    }
    
    private func reset() {
        start = 0.0
        end = 0.0
        passesPerformanceTest = true
    }
}
