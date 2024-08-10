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
            result in
            switch result {
            case .success(let sc):
                break
            case .failure(let error):
                break
            }
        })
    }
    
    weak var uiUpdateDelegate:ViewControllerUpdater!
    
     init(uiUpdateDelegate: ViewControllerUpdater) {
        super.init()
        self.uiUpdateDelegate = uiUpdateDelegate
    }
}
