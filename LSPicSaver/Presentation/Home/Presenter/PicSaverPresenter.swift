//
//  PicSaverPresenter.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation
import LightSpeedCore

protocol PicSaverPresenter {
    func fetchPhoto()
    func onAddButtonPressed()
    func collectionViewUiLoaded()
    func onDeleteButtonPressed(indexPath:IndexPath)
}


class PicSaverPresenterImpl: BasePresenterImpl, PicSaverPresenter{
    
    weak var uiUpdateDelegate:ViewControllerUpdater!
    
     init(uiUpdateDelegate: ViewControllerUpdater) {
        super.init()
        self.uiUpdateDelegate = uiUpdateDelegate
    }
    
    var totalImageCount = 0
    
    func fetchPhoto() {
        interactor?.fetchPhotos(callback: {
           [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let sc):
                self.saveInLocalDb(photoList: sc)
            case .failure(_):
                break
            }
        })
    }
    
    func saveInLocalDb(photoList: [PhotoInfo]) {
        interactor?.removeAllPhoto()
        totalImageCount = 0
//        addInitialData()
        interactor?.savePhotoList(photoInfoList: photoList, completion: {
            [weak self] isSuccess in
            guard let self = self else {
                return
            }
            if isSuccess {
                self.totalImageCount = photoList.count
                self.uiUpdateDelegate.updateCollectionView(list: photoList)
//                self.interactor?.fetchRandomPhoto(index: totalImageCount, completion: {
//                    photoInfo,index in
//                    self.updatePhotoDataSource(photoInfo: photoInfo, index: index)
//                })
               
            }
        })
    }
    
    func updatePhotoDataSource(photoInfo: PhotoInfo?, index:Int) {
        if let photoInfo {
            self.uiUpdateDelegate.replaceNewDataInDataSource(photoInfo: photoInfo, index: index)
        }
    }
    
    func addInitialData() {
        totalImageCount += 1
        let photoInfo = PhotoInfo()
        photoInfo.author = "fetching image..."
        self.uiUpdateDelegate.appendNewDataInDataSource(photoInfo: photoInfo)
    }
    
    func onAddButtonPressed() {
        addInitialData()
    }
    
    func collectionViewUiLoaded(){
        self.interactor?.fetchRandomPhoto(index: totalImageCount - 1, completion: {
            photoInfo,index in
            self.updatePhotoDataSource(photoInfo: photoInfo, index: index)
        })
    }
    
    func onDeleteButtonPressed(indexPath:IndexPath) {
        self.totalImageCount -= 1
        uiUpdateDelegate.deleteDataInDataSource(indexPath: indexPath)
    }
}
