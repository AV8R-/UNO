//
//  ValidationError.swift
//  Model
//
//  Created by Богдан Маншилин on 11/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

enum ValidationError: Error {
    case invalid(field: String, ofType: Any.Type, onObjectOfType: Any.Type, reason: String?)
}
