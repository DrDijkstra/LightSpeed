//
//  DomainModule.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

class DomainModule {
    
    private var photoFetcherService: PhotoFetcherService?
    private var apiService: ApiProtocol?
    private var photoRepository: PhotoRepository?

    
    static var selfRef : DomainModule? = nil
    
    init(URL apigGwUrl : String) {
        apiService = ApiProtocolImpl(baseUrl: apigGwUrl)
    }
    
    static func getInstance() -> DomainModule {
        return selfRef!
    }
    
    static func initModule(_ domainModule : DomainModule) {
        selfRef = domainModule
    }
    
    func getPhotoFetcherService() -> PhotoFetcherService {
        if let service = photoFetcherService {
            return service
        } else {
            let newService = PhotoFetcherServiceImpl()
            photoFetcherService = newService
            return newService
        }
    }
    
    func getPhotoRepository() -> PhotoRepository {
        if let repo = photoRepository {
            return repo
        } else {
            let repo = PhotoRepositoryImpl()
            photoRepository = repo
            return repo
        }
    }
    
    func getApiService() -> ApiProtocol {
        guard let apiService else  {
            fatalError("api service is not initialised")
        }
        return apiService
    }
    
}
