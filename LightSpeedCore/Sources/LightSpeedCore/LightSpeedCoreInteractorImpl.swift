//
//  LightSpeedCoreInteractorImpl.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

class LightSpeedCoreInteractorImpl : LightSpeedCoreInteractor {
    
    
    
    var photoFetcherService:PhotoFetcherService!
    var photoRepository:PhotoRepository!
    
    init() {
        let domainModule = DomainModule.getInstance()
        photoFetcherService = domainModule.getPhotoFetcherService()
        photoRepository = domainModule.getPhotoRepository()
    }
    
    func fetchPhotos(callback: @escaping(ApiCallResult<[PhotoInfo]>) -> Void) {
        photoFetcherService.fetchPhotos(callback: callback)
    }
    
    func savePhotoList(photoInfoList: [PhotoInfo], completion: @escaping (Bool) -> Void){
        photoRepository.savePhotoList(photoInfoList: photoInfoList, completion: completion)
    }
    
    func fetchAllPhotos() -> [PhotoInfo] {
        return photoRepository.fetchAllPhotos()
    }
    
    func fetchRandomPhoto() -> PhotoInfo? {
        return photoRepository.fetchRandomPhoto()
    }
    
    func removeAllPhoto() {
        photoRepository.removeAllPhoto()
    }
    
}
