//
//  Behave+Performance.swift
//  Behave
//
//  Created by Derek Bronston on 3/9/21.
//

import UIKit

public extension Behaviour {
    
    /// Measures performance based on time in relation for FPS. Given that one frame is displayed in 16.67ms at 60 fps. This inititates the test process. Resest start, end and passesPerformanceTest for tracking and enables the CADisplayLink API. 
    func measurePerformance(){
        resetPerformance()
        let displaylink = CADisplayLink(target: self,
                                        selector: #selector(frameRendered))
        displaylink.add(to: .current,
                        forMode: .default)
    }
    
    /// THIS IS CALLED ON EACH FRAME RENDERING PER THE CADisplayLink callback. It checks each frame render and calculates the time based on the returned timestamp. If the frame is rendered in more than 16.67ms it markes it as failing the performnace test.
    @objc private func frameRendered(displaylink: CADisplayLink) {
        if frameStart == 0.0 {
            frameStart = displaylink.timestamp
        } else {
            frameEnd = displaylink.timestamp
            calculatePerformance()
            frameStart = displaylink.timestamp
        }
    }
    
    internal func calculatePerformance(){
        performanceMetrics.append(frameEnd - frameStart)
        if (frameEnd - frameStart) > 0.0167 {
            passesPerformanceTest = false
        }
    }
    
    internal func resetPerformance() {
        frameStart = 0.0
        frameEnd = 0.0
        passesPerformanceTest = true
        performanceMetrics.removeAll()
    }
}
