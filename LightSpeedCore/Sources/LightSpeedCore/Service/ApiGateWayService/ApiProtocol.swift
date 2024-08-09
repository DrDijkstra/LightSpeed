//
//  ApiProtocol.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation
import Alamofire

import Alamofire

protocol ApiProtocol {
    func fetchPhotos(gwCallback: @escaping(ApiGateWayCallResult<ApiPhotoInfo>) -> Void)
}

class ApiProtocolImpl: ApiProtocol {
    func fetchPhotos(gwCallback: @escaping (ApiGateWayCallResult<ApiPhotoInfo>) -> Void) {
        executeRequest(RequestRouter.fetchPhoto, gwCallback: gwCallback)
    }
    
    
    var baseUrl: String
    let sm: Session
    
    init(baseUrl: String) {
        let smConfig = URLSessionConfiguration.default
        smConfig.timeoutIntervalForRequest = 40
        let requestInterceptor = ApiInterceptor()
        sm = Session(configuration: smConfig, interceptor: requestInterceptor)
        self.baseUrl = baseUrl
    }
    
    private func executeRequest<T: BaseResponse>(
        _ urlRequest: URLRequestConvertible,
        gwCallback: @escaping (ApiGateWayCallResult<T>) -> Void
    ) {
        sm.request(urlRequest).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    gwCallback(.success(decodedResponse))
                } catch {
                    gwCallback(.failure(error))
                }
            case .failure(let error):
                gwCallback(.failure(error))
            }
        }
    }
    
    
    func executeRequest<T: BaseResponse>(
        _ urlRequest: URLRequestConvertible,
        gwCallback: @escaping (ApiGateWayCallResult<[T]>) -> Void
    ) {
        sm.request(urlRequest).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode([T].self, from: data)
                    gwCallback(.success(decodedResponse))
                } catch {
                    gwCallback(.failure(error))
                }
            case .failure(let error):
                gwCallback(.failure(error))
            }
        }
    }
}
