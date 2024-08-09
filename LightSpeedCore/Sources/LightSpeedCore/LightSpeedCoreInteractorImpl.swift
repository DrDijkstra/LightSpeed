//
//  LightSpeedCoreInteractorImpl.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

class LightSpeedCoreInteractorImpl : LightSpeedCoreInteractor {
    
    var photoFetcherService:PhotoFetcherService!
    
    init() {
        let domainModule = DomainModule.getInstance()
        photoFetcherService = domainModule.getPhotoFetcherService()
    }
    
    func fetchPhotos(callback: @escaping(ApiCallResult<[PhotoInfo]>) -> Void) {
        photoFetcherService.fetchPhotos(callback: callback)
    }
    
}
