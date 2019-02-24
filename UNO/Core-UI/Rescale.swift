//
//  Rescale.swift
//  Core-UI
//
//  Created by Богдан Маншилин on 24/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public struct Rescale {
    
    var range0: Double, range1: Double, domain0: Double, domain1: Double
    let timingFunction: TimingFunction
    
    public init(domain0: Double, domain1: Double, range0: Double, range1: Double, timing: TimingFunction = .linear) {
        self.range0 = range0
        self.range1 = range1
        self.domain0 = domain0
        self.domain1 = domain1
        self.timingFunction = timing
    }
    
    func interpolate(_ x: Double) -> Double {
        let currentTime = x - domain0
        let duration = domain1 - domain0
        
        return timingFunction.apply(t: currentTime, b: range0, c: range1-range0, d: duration)
    }
    
    func uninterpolate(_ x: Double) -> Double {
        let b: Double = (domain1 - domain0) != 0 ? domain1 - domain0 : 1 / domain1;
        return (x - domain0) / b
    }
    
    public func rescale(_ x: Double)  -> Double {
        return min(range1, max(range0, interpolate(x)))
    }
}

public enum TimingFunction {
    case linear
    case quadraticInOut
    case quatricInOut
    
    var eqasion: EasingEquasion {
        switch self {
        case .linear: return LinearEquasion()
        case .quadraticInOut: return QuadraticInOut()
        case .quatricInOut: return QuatricInOut()
        }
    }
    
    /// - Parameters:
    ///   - t: current time
    ///   - b: start value
    ///   - c: change in value
    ///   - d: duration
    func apply(t: Double, b: Double, c: Double, d: Double) -> Double {
        return eqasion.apply(t: t, b: b, c: c, d: d)
    }
}

public protocol EasingEquasion {
    /// - Parameters:
    ///   - t: current time
    ///   - b: start value
    ///   - c: change in value
    ///   - d: duration
    func apply(t: Double, b: Double, c: Double, d: Double) -> Double
}

public struct LinearEquasion: EasingEquasion {
    public func apply(t: Double, b: Double, c: Double, d: Double) -> Double {
        return c*t/d + b
    }
}

public struct QuadraticInOut: EasingEquasion {
    public func apply(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t/d
        if (t < 1) {
            return c*t*t + b
        }
        t -= 1
        return -c * (t*(t-2) - 1) + b;
    }
}

public struct QuatricInOut: EasingEquasion {
    public func apply(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t / (d/2)
        if (t < 1) {
            return c/2*t*t*t*t + b
        }
        t -= 2;
        return -c * (t*t*t*t - 2) + b;
    }
}
