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
    func fetchPhotos(gwCallback: @escaping(ApiGateWayCallResult<[ApiPhotoInfo]>) -> Void)
}

class ApiProtocolImpl: ApiProtocol {
    func fetchPhotos(gwCallback: @escaping (ApiGateWayCallResult<[ApiPhotoInfo]>) -> Void) {
        executeRequest(RequestRouter.fetchPhoto, gwCallback: gwCallback)
    }
    
    
    var baseUrl: String
    let sm: Session
    
    init(baseUrl: String) {
        let smConfig = URLSessionConfiguration.default
        smConfig.timeoutIntervalForRequest = 40
        let requestInterceptor = ApiInterceptor()
        sm = Session(configuration: smConfig, interceptor: requestInterceptor)
        RequestRouter.baseUrl = baseUrl
        self.baseUrl = baseUrl
    }
    
    private func executeRequest<T: BaseResponse>(
        _ urlRequest: URLRequestConvertible,
        gwCallback: @escaping (ApiGateWayCallResult<T>) -> Void
    ) {
        sm.request(urlRequest).responseData {[weak self] response in
            guard let self else {
                return
            }
            switch response.result {
            case .success(let data):
                self.printPrettyJSON(from: data, isSuccess: true)
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    gwCallback(.success(decodedResponse))
                } catch {
                    gwCallback(.failure(error))
                }
            case .failure(let error):
                if let data = response.data {
                    // Prettify and print the JSON response for failure
                    self.printPrettyJSON(from: data, isSuccess: true)
                }
                gwCallback(.failure(error))
            }
        }
    }
    
    
    func executeRequest<T: BaseResponse>(
        _ urlRequest: URLRequestConvertible,
        gwCallback: @escaping (ApiGateWayCallResult<[T]>) -> Void
    ) {
        sm.request(urlRequest).responseData {[weak self] response in
            guard let self else {
                return
            }
            switch response.result {
            case .success(let data):
                self.printPrettyJSON(from: data, isSuccess: true)

                do {
                    let decodedResponse = try JSONDecoder().decode([T].self, from: data)
                    gwCallback(.success(decodedResponse))
                } catch {
                    gwCallback(.failure(error))
                }
            case .failure(let error):
                if let data = response.data {
                    // Prettify and print the JSON response for failure
                    self.printPrettyJSON(from: data, isSuccess: true)
                }
                gwCallback(.failure(error))
            }
        }
    }
    


    private func printPrettyJSON(from data: Data, isSuccess: Bool) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyPrintedData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            if let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
                let statusEmoji = isSuccess ? "✅✅✅" : "❌❌❌"
                print("\(statusEmoji) ------------ Response ------------ \(statusEmoji)")
                print(prettyPrintedString)
            }
        } catch {
            print("Failed to prettify JSON: \(error)")
        }
    }

}
