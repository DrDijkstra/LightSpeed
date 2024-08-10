//
//  ViewController.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import UIKit

protocol ViewControllerUpdater : AnyObject{
    
}

class ViewController: BaseViewController {

    var presenter: PicSaverPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PicSaverPresenterImpl(uiUpdateDelegate: self)
    }
    
    static func getViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        return vc
    }

}

extension ViewController: ViewControllerUpdater {
    
}

