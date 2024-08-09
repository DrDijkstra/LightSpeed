//
//  PhotoFetcherService.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

protocol PhotoFetcherService {
    func fetchPhotos(callback: @escaping(ApiCallResult<[PhotoInfo]>) -> Void)
}

class PhotoFetcherServiceImpl: PhotoFetcherService {
    
    var apiService: ApiProtocol?
    
    init() {
        self.apiService = DomainModule.getInstance().getApiService()
    }
    
    func fetchPhotos(callback: @escaping(ApiCallResult<[PhotoInfo]>) -> Void) {
        apiService?.fetchPhotos(gwCallback: {
            result in
            switch result {
            case .success(let apiPhotoInfos):
                callback(.success(sc: []))
            case .failure(let error):
                callback(.failure(error: ResponseStatus()))
            }
        })

    }
    
}
