//
//  ApiGateWayCallResult.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

public enum ApiGateWayCallResult<T> {
    case success(T)
    case failure(Error)      
}


