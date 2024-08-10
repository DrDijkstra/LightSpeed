//
//  PhotoCollectionViewCell.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import UIKit
import LightSpeedCore
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var authorName: UILabel!
    
    
    func setView(info: PhotoInfo) {
        if let imgUrlString = info.downloadUrl, let imgUrl = URL(string: imgUrlString) {
            imageView.kf.setImage(with: imgUrl)
        }
        authorName.text = info.author
    }

}
