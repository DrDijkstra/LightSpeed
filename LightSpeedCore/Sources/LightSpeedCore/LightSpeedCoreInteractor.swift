//
//  LightSpeedCoreInteractor.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

public protocol LightSpeedCoreInteractor {
    func fetchPhotos(callback: @escaping(ApiCallResult<[PhotoInfo]>) -> Void)
    func savePhotoList(photoInfoList: [PhotoInfo], completion: @escaping (Bool) -> Void)
    func fetchAllPhotos() -> [PhotoInfo]
    func fetchRandomPhoto() -> PhotoInfo?
    func removeAllPhoto()
}
