//
//  UIView+Extention.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 11/8/24.
//

import Foundation
import UIKit

extension UIView{
    func makeElevatedView(_ shadowRadius : CGFloat = 5) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.5
    }
}
