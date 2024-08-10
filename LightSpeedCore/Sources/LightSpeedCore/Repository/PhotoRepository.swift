//
//  PhotoRepository.swift
//
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation
import CoreData

protocol PhotoRepository {
    func savePhotoList(photoInfoList: [PhotoInfo])
    func fetchAllPhotos() -> [PhotoInfo]
    func fetchRandomPhoto() -> PhotoInfo?
}

class PhotoRepositoryImpl: PhotoRepository {

    func savePhotoList(photoInfoList: [PhotoInfo]) {
        let context = CoreDataStack.shared.context

        // Begin a background context for saving data
        context.perform {
            // Fetch existing photos to prevent duplicates
            let fetchRequest: NSFetchRequest<PhotoInfoCore> = PhotoInfoCore.fetchRequest()
            do {
                let existingPhotos = try context.fetch(fetchRequest)
                let existingPhotoIds = Set(existingPhotos.map { $0.id ?? "" })
                
                // Convert PhotoInfo list to Photo entities
                for photoInfo in photoInfoList {
                    // Check if the photo already exists
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
            } catch {
                print("Failed to fetch or save photos: \(error)")
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
