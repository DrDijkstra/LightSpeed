import Foundation
import XCoordinator
import UIKit

enum MainRoute: Route {
    case initial
}

class MainCoordinator: NavigationCoordinator<MainRoute> {
    
    init() {
         super.init(initialRoute: .initial)
    }
    
    init(rootViewController: RootViewController) {
        super.init(rootViewController: rootViewController)
    }

    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let viewController = ViewController.getViewController()
            return .push(viewController)
        }
    }
}
