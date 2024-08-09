import Foundation
import XCoordinator
import UIKit

enum MainRoute: Route {
    case initial
}

class MainCoordinator: NavigationCoordinator<MainRoute> {
    private let navigationController: UINavigationController

    // Initializer with no parameters
     init(initialRoute: MainRoute) {
        self.navigationController = UINavigationController() // Initialize here
        super.init(initialRoute: initialRoute)
    }
    
    // Initializer with a specific root view controller
    init(rootViewController: UIViewController) {
        self.navigationController = UINavigationController(rootViewController: rootViewController) // Initialize here
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
