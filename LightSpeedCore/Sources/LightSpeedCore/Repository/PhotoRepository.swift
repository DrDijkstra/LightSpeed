//
//  PhotoRepository.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation
import CoreData
import Foundation
import CoreData

protocol PhotoRepository {
    @discardableResult
    func savePhotoList(photoInfoList: [PhotoInfo], completion: @escaping (Bool) -> Void)
    func fetchAllPhotos() -> [PhotoInfo]
    func fetchRandomPhoto() -> PhotoInfo?
    func removeAllPhoto()
}

class PhotoRepositoryImpl: PhotoRepository {
    
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

    func fetchAllPhotos() -> [PhotoInfo] {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<PhotoInfoCore> = PhotoInfoCore.fetchRequest()
        do {
            let photos = try context.fetch(fetchRequest)
            return photos.map { photo in
                PhotoInfo(
                    id: photo.id ?? "",
                    author: photo.authorName ?? "",
                    width: Int(photo.width),
                    height: Int(photo.height),
                    url: photo.url ?? "",
                    downloadUrl: photo.downloadUrl ?? ""
                )
            }
        } catch {
            print("Failed to fetch photos: \(error)")
            return []
        }
    }

    func fetchRandomPhoto() -> PhotoInfo? {
        let photos = fetchAllPhotos()
        return photos.randomElement()
    }
}
