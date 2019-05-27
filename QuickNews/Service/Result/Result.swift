//
//  Result.swift
//  AdvancedSwift
//
//  Created by Sarannya on 10/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
//

import Foundation

enum Result<T, E : Error>{
    case success(T)
    case failure(E)
}
