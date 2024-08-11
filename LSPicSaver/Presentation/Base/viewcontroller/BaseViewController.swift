//
//  BaseViewController.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showDeleteConfirmationAlert( deleteAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Delete Confirmation",
                                                message: "Are you sure you want to delete?",
                                                preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            deleteAction() // Perform the delete action
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
