//
//  BasePresenter.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import LightSpeedCore

protocol BasePresenter {
    
}

class BasePresenterImpl : BasePresenter {
    var interactor: LightSpeedCoreInteractor?

    init() {
        self.interactor = LightSpeedCore.getInstance().getInteractor()
    }
}
