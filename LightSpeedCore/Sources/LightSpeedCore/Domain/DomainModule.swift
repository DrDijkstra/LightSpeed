//
//  DomainModule.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

class DomainModule {
    
    private var photoFetcherService: PhotoFetcherService?
    
    static var selfRef : DomainModule? = nil
    
    init(URL apigGwUrl : String) {
        
    }
    
    static func getInstance() -> DomainModule {
        return selfRef!
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

}
