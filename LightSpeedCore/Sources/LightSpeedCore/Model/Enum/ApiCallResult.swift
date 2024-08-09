//
//  ApiCallResult.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation


public enum ApiCallResult <T>{
    case success(sc : T)
    case failure(error : ResponseStatus)
}
