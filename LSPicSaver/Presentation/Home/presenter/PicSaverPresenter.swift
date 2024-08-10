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
}


class PicSaverPresenterImpl: BasePresenterImpl, PicSaverPresenter{
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
    
    weak var uiUpdateDelegate:ViewControllerUpdater!
    
     init(uiUpdateDelegate: ViewControllerUpdater) {
        super.init()
        self.uiUpdateDelegate = uiUpdateDelegate
    }
    
    func saveInLocalDb(photoList: [PhotoInfo]) {
        interactor?.removeAllPhoto()
        interactor?.savePhotoList(photoInfoList: photoList, completion: {
            [weak self] isSuccess in
            guard let self = self else {
                return
            }
            if isSuccess {
                if let randomPhoto = self.interactor?.fetchRandomPhoto() {
                    self.uiUpdateDelegate.updateCollectionView(list: [randomPhoto])
                }
               
            }
        })
        
    }
}
