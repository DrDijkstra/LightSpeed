//
//  File.swift
//  
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation
import Alamofire


enum RequestRouter : URLRequestConvertible, URLConvertible{
    case fetchPhoto
    
    static var baseUrl = "https://picsum.photos/"
    
    var method: HTTPMethod {
        switch self {
        case .fetchPhoto:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchPhoto:
            return ApiUrl.photoList.rawValue
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: try getFullUrl())
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .fetchPhoto:
            break
        }
        return urlRequest
    }
    
    public func getFullUrl()throws -> URL{
        return try RequestRouter.baseUrl.asURL().appendingPathComponent(path)
    }
    


    func asURL() throws -> URL {
        return URL(string: path)!
    }
    
    

}
