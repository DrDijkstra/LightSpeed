//
//  MainApplication.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation
import UIKit
import XCoordinator
import LightSpeedCore

class MainApplication: UIApplication {
    
    override init() {
        super.init()
        initSdk()
    }
    
    
    func initSdk () {
        LightSpeedCore.getInstance().initSDK(apiGwURl: Config.baseUrl)
    }
    
}
