//
//  Error.swift
//  AdvancedSwift
//
//  Created by Sarannya on 10/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

import Foundation

enum ErrorResult : Error {
    case network(string : String)
    case parser(string:String)
    case custom(string:String)
}
