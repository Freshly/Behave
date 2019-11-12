//
//  Behave+Events.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 11/12/19.
//  Copyright © 2019 Freshly. All rights reserved.
//

import Foundation

extension BehaveV2 {
    
    func setEvent(eventString:BehaveEvent) -> String {
        return eventString.rawValue
    }
    
    func send(identity:String){
        guard let testIdentifier = identifier else { return }
        identifier = nil
        event.accept(testIdentifier + identity)
    }
    
    func track(eventString: BehaveEvent){
        event.accept(eventString.rawValue)
    }
}
