// This file is autogenerated. Take a look at `Preprocessor` target in RxSwift project
//
//  PrimitiveSequence+Zip+arity.swift
//  RxSwift
//
//  Created by Krunoslav Zaher on 5/23/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

// 2

extension PrimitiveSequenceType where TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, resultSelector: @escaping (E1, E2) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>)
        -> PrimitiveSequence<TraitType, (E1, E2)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable()
        )
        )
    }
}

extension PrimitiveSequenceType where TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, resultSelector: @escaping (E1, E2) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>)
        -> PrimitiveSequence<TraitType, (E1, E2)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable()
        )
        )
    }
}

// 3

extension PrimitiveSequenceType where TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, resultSelector: @escaping (E1, E2, E3) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable()
        )
        )
    }
}

extension PrimitiveSequenceType where TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, resultSelector: @escaping (E1, E2, E3) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable()
        )
        )
    }
}

// 4

extension PrimitiveSequenceType where TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, resultSelector: @escaping (E1, E2, E3, E4) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable()
        )
        )
    }
}

extension PrimitiveSequenceType where TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, resultSelector: @escaping (E1, E2, E3, E4) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable()
        )
        )
    }
}

// 5

extension PrimitiveSequenceType where TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, resultSelector: @escaping (E1, E2, E3, E4, E5) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable()
        )
        )
    }
}

extension PrimitiveSequenceType where TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, resultSelector: @escaping (E1, E2, E3, E4, E5) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable()
        )
        )
    }
}

// 6

extension PrimitiveSequenceType where TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5, E6)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable()
        )
        )
    }
}

extension PrimitiveSequenceType where TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5, E6)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable()
        )
        )
    }
}

// 7

extension PrimitiveSequenceType where TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5, E6, E7)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable()
        )
        )
    }
}

extension PrimitiveSequenceType where TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5, E6, E7)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable()
        )
        )
    }
}

// 8

extension PrimitiveSequenceType where TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>, _ source8: PrimitiveSequence<TraitType, E8>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7, E8) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == SingleTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>, _ source8: PrimitiveSequence<TraitType, E8>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5, E6, E7, E8)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable()
        )
        )
    }
}

extension PrimitiveSequenceType where TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - parameter resultSelector: Function to invoke for each series of elements at corresponding indexes in the sources.
     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>, _ source8: PrimitiveSequence<TraitType, E8>, resultSelector: @escaping (E1, E2, E3, E4, E5, E6, E7, E8) throws -> ElementType)
        -> PrimitiveSequence<TraitType, ElementType> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable(),
            resultSelector: resultSelector
        )
        )
    }
}

extension PrimitiveSequenceType where ElementType == Any, TraitType == MaybeTrait {
    /**
     Merges the specified observable sequences into one observable sequence of tuples whenever all of the observable sequences have produced an element at a corresponding index.

     - seealso: [zip operator on reactivex.io](http://reactivex.io/documentation/operators/zip.html)

     - returns: An observable sequence containing the result of combining elements of the sources using the specified result selector function.
     */
    public static func zip<E1, E2, E3, E4, E5, E6, E7, E8>(_ source1: PrimitiveSequence<TraitType, E1>, _ source2: PrimitiveSequence<TraitType, E2>, _ source3: PrimitiveSequence<TraitType, E3>, _ source4: PrimitiveSequence<TraitType, E4>, _ source5: PrimitiveSequence<TraitType, E5>, _ source6: PrimitiveSequence<TraitType, E6>, _ source7: PrimitiveSequence<TraitType, E7>, _ source8: PrimitiveSequence<TraitType, E8>)
        -> PrimitiveSequence<TraitType, (E1, E2, E3, E4, E5, E6, E7, E8)> {
        return PrimitiveSequence(raw: Observable.zip(
            source1.asObservable(), source2.asObservable(), source3.asObservable(), source4.asObservable(), source5.asObservable(), source6.asObservable(), source7.asObservable(), source8.asObservable()
        )
        )
    }
}
