//
//  PhotoCollectionViewCell.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import UIKit
import LightSpeedCore
import Kingfisher
import SkeletonView

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
            imageView.isSkeletonable = true
            imageView.showAnimatedGradientSkeleton()
        }

        func setView(info: PhotoInfo) {
            if let imgUrlString = info.downloadUrl, let imgUrl = URL(string: imgUrlString) {
                imageView.showAnimatedGradientSkeleton()
                
                imageView.kf.setImage(with: imgUrl, completionHandler: { result in
                    self.imageView.hideSkeleton()
                })
            } else {
                imageView.hideSkeleton()
            }
            authorName.text = info.author
        }

}
