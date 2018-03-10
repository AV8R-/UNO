//
//  Memento.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 15/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/// Protocol for object that has state
public protocol Stated {
    /// Type of the state that object holds
    associatedtype State
}

/// Protocol for Memento pattern. It is the protocol for object that can restore
/// from the memento
public protocol Originator: Stated {
    /// Type of the memento from wich this object could be restored
    associatedtype Memento: Stated where State == Memento.State
    
    /// Restore this object from memento
    ///
    /// - Parameter from: memento to restore this object from
    func restore(from: Memento)
    
    /// Creates memento for current object state
    func makeMemento() -> Memento
}

extension Originator {
    fileprivate func typeOfState() -> Any.Type {
        return State.self
    }
}

/// Protocol for Memento design pattern. It's actually Memento
public protocol Mementing {
    /// The Type of the objects that created this memento
    var originatorType: Any.Type { get }
    
    /// Try to restore object from this memento
    ///
    /// - Parameter originator: object to restore
    func restore<O>(originator: O) -> Bool where O: Originator
}

/// Default generic implementation of the Memento
public struct Memento<S>: Stated, Mementing {
    public typealias State = S
    public var originatorType: Any.Type
    private var state: S
    
    init<O>(state: State, originatorType: O.Type) where O: Originator, O.State == State {
        self.originatorType = originatorType
        self.state = state
    }
    
    public func restore<O>(originator: O) -> Bool where O: Originator {
        if originatorType == type(of: originator),
            State.Type.self == originator.typeOfState()
        {
            originator.restore(from: self as! O.Memento)
            return true
        }
        return false
    }
}

/// Composition of multiple saved states. Stores all saved states as `Mementig`
/// protocol. Could be used to try restore some object from one of the states
/// it holds
public class MementoStore: Mementing {
    public var originatorType: Any.Type = Any.self
    private var mementos: [Mementing] = []
    
    /// Adds new saved state to the store
    public func add(memento: Mementing) {
        remove(memento: memento)
        mementos.append(memento)
    }
    
    /// Removes state with same originatorType as passed memento
    func remove(memento: Mementing) {
        mementos = mementos.filter { $0.originatorType != memento.originatorType }
    }
    
    /// Try to restore state of the object from all saved states if there is
    /// suitable memento
    ///
    /// - Parameter originator: object to restore
    ///
    /// - Returns: true if restore was successfull, false if there is no such
    /// memento
    public func restore<O>(originator: O) -> Bool where O : Originator {
        var res = false
        var i = 0
        while res == false, i < mementos.count {
            res = mementos[i].restore(originator: originator)
            i += 1
        }
        return res
    }
}
