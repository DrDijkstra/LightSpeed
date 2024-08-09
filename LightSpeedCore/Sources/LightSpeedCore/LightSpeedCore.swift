//
//  MainApplication.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

public class LightSpeedCore {
    
    static var selfRef : LightSpeedCore? 
    var domainModule : DomainModule?

    public static func getInstance() -> LightSpeedCore {
        guard selfRef != nil else {
            selfRef = LightSpeedCore()
            return selfRef!
            
        }
        return selfRef!
    }
    
    private init () {
        
    }
    
    public func initSDK (apiGwURl: String) {
        domainModule = DomainModule(URL: apiGwURl)
    }
}
