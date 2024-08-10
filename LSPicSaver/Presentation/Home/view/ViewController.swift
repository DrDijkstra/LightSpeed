//
//  ViewController.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//

import UIKit
import LightSpeedCore
import CHTCollectionViewWaterfallLayout

protocol ViewControllerUpdater : AnyObject{
    func updateCollectionView(list: [PhotoInfo])
}

class ViewController: BaseViewController {

    var presenter: PicSaverPresenter!
    
    var dataSource:[PhotoInfo] = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PicSaverPresenterImpl(uiUpdateDelegate: self)
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchPhoto()
    }
    
    @IBAction func onAddPhotoButtonPressed(_ sender: Any) {
       
    }

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.setView(info: dataSource[indexPath.row])
        cell.authorName.text = dataSource[indexPath.row].author
        return cell
    }
}

extension ViewController: ViewControllerUpdater {
    func updateCollectionView(list: [PhotoInfo]) {
        self.dataSource = list
        self.collectionView.reloadData()
    }
    
}

extension ViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource[indexPath.row]
        let height = item.height! + 50
        let width = item.width!
        
        let imageSize = CGSize(width: width, height: height)
        return imageSize
    }
    

    
    
}

extension ViewController {
    static func getViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        return vc
    }
}

