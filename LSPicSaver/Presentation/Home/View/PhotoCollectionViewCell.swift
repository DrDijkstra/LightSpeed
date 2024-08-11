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

protocol PhotoCollectionDelegate:AnyObject {
    func onCrossButtonPressed(in cell: PhotoCollectionViewCell)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    weak var delegate:PhotoCollectionDelegate!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            imageView.isSkeletonable = true
            imageView.showAnimatedGradientSkeleton()
        }

        func setView(info: PhotoInfo) {
            DispatchQueue.main.async {
                [weak self] in
                guard let self = self else{
                    return
                }

                if let imgUrlString = info.downloadUrl, let imgUrl = URL(string: imgUrlString) {
                    self.imageView.showAnimatedGradientSkeleton()
                    self.imageView.kf.setImage(with: imgUrl, completionHandler: { result in
                        self.imageView.hideSkeleton()
                        if let authorNameText = info.author {
                            self.authorName.text = authorNameText
                        }
                    })
                } else {
                    self.imageView.hideSkeleton()
                }
            }
        }
    
    
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        delegate.onCrossButtonPressed(in: self)
    }
    
}
