//
//  PhotoRepository.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation
import CoreData

protocol PhotoRepository {
    @discardableResult
    func savePhotoList(photoInfoList: [PhotoInfo], completion: @escaping (Bool) -> Void)
    func fetchAllPhotos(completion: @escaping ([PhotoInfo]) -> Void)
    func fetchRandomPhoto(index:Int, completion: @escaping (PhotoInfo?, Int) -> Void)
    func removeAllPhoto()
}

class PhotoRepositoryImpl: PhotoRepository {
    
    var totalImagesCount: Int = 0
    
    func removeAllPhoto() {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PhotoInfoCore.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all photos: \(error)")
        }
    }

    @discardableResult
    func savePhotoList(photoInfoList: [PhotoInfo], completion: @escaping (Bool) -> Void) {
        totalImagesCount = photoInfoList.count
        let context = CoreDataStack.shared.context

        context.perform {
            let fetchRequest: NSFetchRequest<PhotoInfoCore> = PhotoInfoCore.fetchRequest()
            do {
                let existingPhotos = try context.fetch(fetchRequest)
                let existingPhotoIds = Set(existingPhotos.map { $0.id ?? "" })
                
                for photoInfo in photoInfoList {
                    if !existingPhotoIds.contains(photoInfo.id ?? "") {
                        let photo = PhotoInfoCore(context: context)
                        photo.id = photoInfo.id
                        photo.authorName = photoInfo.author
                        photo.width = Int64(photoInfo.width ?? 0)
                        photo.height = Int64(photoInfo.height ?? 0)
                        photo.url = photoInfo.url
                        photo.downloadUrl = photoInfo.downloadUrl
                    }
                }
                
                // Save the context
                try context.save()
                completion(true) // Successfully saved
            } catch {
                print("Failed to fetch or save photos: \(error)")
                completion(false) // Failed to save
            }
        }
    }

    func fetchAllPhotos(completion: @escaping ([PhotoInfo]) -> Void) {
        let context = CoreDataStack.shared.context
        context.perform {
            let fetchRequest: NSFetchRequest<PhotoInfoCore> = PhotoInfoCore.fetchRequest()
            do {
                let photos = try context.fetch(fetchRequest)
                let photoInfoList = photos.map { photo in
                    PhotoInfo(
                        id: photo.id ?? "",
                        author: photo.authorName ?? "",
                        width: Int(photo.width),
                        height: Int(photo.height),
                        url: photo.url ?? "",
                        downloadUrl: photo.downloadUrl ?? ""
                    )
                }
                completion(photoInfoList)
            } catch {
                print("Failed to fetch photos: \(error)")
                completion([])
            }
        }
    }

    func fetchRandomPhoto(index: Int, completion: @escaping (PhotoInfo?, Int) -> Void) {
            guard totalImagesCount > 0 else {
                completion(nil, index)
                return
            }
            
            let randomIndex = Int.random(in: 0..<totalImagesCount)
            let context = CoreDataStack.shared.context
            context.perform {
                let fetchRequest: NSFetchRequest<PhotoInfoCore> = PhotoInfoCore.fetchRequest()
                fetchRequest.fetchOffset = randomIndex
                fetchRequest.fetchLimit = 1
                
                do {
                    let photos = try context.fetch(fetchRequest)
                    let photoInfo = photos.first.flatMap { photo in
                        PhotoInfo(
                            id: photo.id ?? "",
                            author: photo.authorName ?? "",
                            width: Int(photo.width),
                            height: Int(photo.height),
                            url: photo.url ?? "",
                            downloadUrl: photo.downloadUrl ?? ""
                        )
                    }
                    completion(photoInfo, index)
                } catch {
                    print("Failed to fetch random photo: \(error)")
                    completion(nil, index)
                }
            }
        }
}
