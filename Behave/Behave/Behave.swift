//
//  BDTestsBDD.swift
//  BDTestsUnitTests
//
//  Created by Derek Bronston on 7/31/18.
//  Copyright © 2018 Derek Bronston. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import OHHTTPStubs

class Behave{
    var eventPub = PublishSubject<String>()
    var event:Observable<String>!
    var logoutPub = PublishSubject<String>()
    var logout:Observable<String>!
    var identifier:String?
    
    static let sharedInstance = Behave()

    func setUp() {
        self.event = eventPub
        _ = eventPub.observeOn(MainScheduler.instance)
        
        self.logout = logoutPub
        _ = logoutPub.observeOn(MainScheduler.instance)
    }
    
    func send(identity:String){
        guard let testIdentifier = identifier else { return }
        identifier = nil
        eventPub.onNext(testIdentifier + identity)
    }
    
    func track(eventString: BehaveEvent){
        eventPub.onNext(eventString.rawValue)
    }
    
    func setEvent(eventString:BehaveEvent) -> String {
        return eventString.rawValue
    }
    
    func execute(complete:(BehaveEvent)->Void){
        let bag = DisposeBag()
        Behave.sharedInstance.event.subscribe(onNext: {(str) in
            
        }).disposed(by: bag)
    }
    
    func action(uiElement: BDUIElement) {
        
    }
}


