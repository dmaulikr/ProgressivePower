//
//  PPError.swift
//  ProgressivePower
//
//  Created by Michael Lee on 8/13/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import Foundation

enum PPError : ErrorType {
    case NoValue
    case DuplicateValue
    case DBFail
    case InvalidValue
    
    case UnexpectedError
}