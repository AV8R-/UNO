//
//  Resorvable.swift
//  UNO
//
//  Created by Богдан Маншилин on 23/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

enum ResolveError: Error {
    case serviceNotRegistered
}

protocol Resolving {
    func resolve<T>() throws -> T
}

extension Resolving {
    func resolve<T>() throws -> T {
        guard let service = AppDelegate.container.resolve(T.self) else {
            throw ResolveError.serviceNotRegistered
        }
        return service
    }
}
