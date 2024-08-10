import Foundation
import XCoordinator
import UIKit

enum MainRoute: Route {
    case initial
}

class MainCoordinator: NavigationCoordinator<MainRoute> {
    
    static private var shared : MainCoordinator? = nil
    
    static func getInstance() -> MainCoordinator{
        if shared == nil{
            shared = MainCoordinator()
        }
        return shared!
    }
    
    init() {
         super.init(initialRoute: .initial)
    }
    

    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let viewController = ViewController.getViewController()
            return .push(viewController)
        }
    }
}
