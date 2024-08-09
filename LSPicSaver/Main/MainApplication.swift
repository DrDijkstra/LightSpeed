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
    
    var window = UIWindow()
    var router:StrongRouter<MainRoute>!
    
    override init() {
        super.init()
        startRouter()
    }
    
    func startRouter () {
        let mainCordinator = MainCoordinator()
        router = mainCordinator.strongRouter
        router.setRoot(for: window)
    }
    
    func initSdk () {
        LightSpeedCore.getInstance().initSDK(apiGwURl: Config.baseUrl)
    }
    
}
