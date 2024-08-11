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
    func appendNewDataInDataSource(photoInfo: PhotoInfo)
    func replaceNewDataInDataSource(photoInfo: PhotoInfo, index: Int)
    func deleteDataInDataSource(indexPath: IndexPath)
}

class PhotoCollectionViewController: BaseViewController {

    var presenter: PicSaverPresenter!
    var dataSource:[PhotoInfo] = []
    
    var refreshControl = UIRefreshControl()

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PicSaverPresenterImpl(uiUpdateDelegate: self)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        collectionView.addGestureRecognizer(gesture)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }

    @objc private func refreshData() {
        presenter.fetchPhoto()
    }
    
    @objc func handleLongPressGesture(_ gesture : UILongPressGestureRecognizer) {
        switch gesture.state {

        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else{
                return
            }
            collectionView.beginInteractiveMovementForItem(at: indexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchPhoto()
    }
    
    @IBAction func onAddPhotoButtonPressed(_ sender: Any) {
        presenter.onAddButtonPressed()
    }
    
    func appendNewDataInDataSource(photoInfo: PhotoInfo) {
        DispatchQueue.main.async {
            self.dataSource.append(photoInfo)
            let newIndexPath = IndexPath(item: self.dataSource.count - 1, section: 0)
            
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: [newIndexPath])
                self.presenter.collectionViewUiLoaded()
            }, completion: nil)
        }
    }
}


extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell

        cell.setView(info: dataSource[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = dataSource.remove(at: sourceIndexPath.row)
        dataSource.insert(item, at: destinationIndexPath.row)
        // Force layout update
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension PhotoCollectionViewController: ViewControllerUpdater {
    func deleteDataInDataSource(indexPath: IndexPath) {
        self.addButton.isEnabled = false
        DispatchQueue.main.async {
            if indexPath.row < self.dataSource.count {
                self.dataSource.remove(at: indexPath.row)
                self.collectionView.performBatchUpdates({
                    self.collectionView.deleteItems(at: [indexPath])
                }, completion: {_ in
                    self.addButton.isEnabled = true
                })
            }else {
                self.addButton.isEnabled = true
            }
            
        }
    }
    
    func replaceNewDataInDataSource(photoInfo: PhotoInfo, index: Int) {
        guard index >= 0 && index < dataSource.count else {
            return
        }

        dataSource[index] = photoInfo
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: index, section: 0)
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: [indexPath])
            }, completion: nil)
        }
    }

    func updateCollectionView(list: [PhotoInfo]) {
        DispatchQueue.main.async{
            self.dataSource = list
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
}

extension PhotoCollectionViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource[indexPath.row]
        let height = item.height ?? 100
        let width = item.width ?? 100
        
        let imageSize = CGSize(width: width, height: height)
        return imageSize
    }
}

extension PhotoCollectionViewController:PhotoCollectionDelegate {
    func onCrossButtonPressed(in cell: PhotoCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        showDeleteConfirmationAlert(deleteAction: {
            self.presenter.onDeleteButtonPressed(indexPath: indexPath)
        })
    }
    
    
}

extension PhotoCollectionViewController {
    static func getViewController() -> PhotoCollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! PhotoCollectionViewController
        return vc
    }
}

