//
//  ControlEvent.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 8/28/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxSwift

/// A protocol that extends `ControlEvent`.
public protocol ControlEventType: ObservableType {
    /// - returns: `ControlEvent` interface
    func asControlEvent() -> ControlEvent<E>
}

/**
 A trait for `Observable`/`ObservableType` that represents an event on a UI element.

 Properties:

 - it never fails,
 - it doesn’t send any initial value on subscription,
 - it `Complete`s the sequence when the control deallocates,
 - it never errors out, and
 - it delivers events on `MainScheduler.instance`.

 **The implementation of `ControlEvent` will ensure that sequence of events is being subscribed on main scheduler
  (`subscribeOn(ConcurrentMainScheduler.instance)` behavior).**

 **It is the implementor’s responsibility to make sure that all other properties enumerated above are satisfied.**

 **If they aren’t, using this trait will communicate wrong properties, and could potentially break someone’s code.**

 **If the `events` observable sequence passed into thr initializer doesn’t satisfy all enumerated
  properties, don’t use this trait.**
 */
public struct ControlEvent<PropertyType>: ControlEventType {
    public typealias E = PropertyType

    let _events: Observable<PropertyType>

    /// Initializes control event with a observable sequence that represents events.
    ///
    /// - parameter events: Observable sequence that represents events.
    /// - returns: Control event created with a observable sequence of events.
    public init<Ev: ObservableType>(events: Ev) where Ev.E == E {
        _events = events.subscribeOn(ConcurrentMainScheduler.instance)
    }

    /// Subscribes an observer to control events.
    ///
    /// - parameter observer: Observer to subscribe to events.
    /// - returns: Disposable object that can be used to unsubscribe the observer from receiving control events.
    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return _events.subscribe(observer)
    }

    /// - returns: `Observable` interface.
    public func asObservable() -> Observable<E> {
        return _events
    }

    /// - returns: `ControlEvent` interface.
    public func asControlEvent() -> ControlEvent<E> {
        return self
    }
}
