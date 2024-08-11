//
//  PresenterUnitTests.swift
//  LSPicSaverTests
//
//  Created by Sanjay Dey on 11/8/24.
//



import XCTest
@testable import LSPicSaver
import LightSpeedCore

// Mock classes for dependencies
class MockViewControllerUpdater: ViewControllerUpdater {
    var didCallUpdateCollectionView = false
    var didCallAppendNewDataInDataSource = false
    var didCallReplaceNewDataInDataSource = false
    var didCallDeleteDataInDataSource = false
    
    func updateCollectionView(list: [PhotoInfo]) {
        didCallUpdateCollectionView = true
    }
    
    func appendNewDataInDataSource(photoInfo: PhotoInfo) {
        didCallAppendNewDataInDataSource = true
    }
    
    func replaceNewDataInDataSource(photoInfo: PhotoInfo, index: Int) {
        didCallReplaceNewDataInDataSource = true
    }
    
    func deleteDataInDataSource(indexPath: IndexPath) {
        didCallDeleteDataInDataSource = true
    }
}


class MockInteractor: LightSpeedCoreInteractor {
    var didCallFetchPhotos = false
    var didCallSavePhotoList = false
    var didCallFetchAllPhotos = false
    var didCallFetchRandomPhoto = false
    var didCallRemoveAllPhoto = false
    
    var simulateSuccess = true

    
    func fetchPhotos(callback: @escaping (ApiCallResult<[PhotoInfo]>) -> Void) {
            didCallFetchPhotos = true
            if simulateSuccess {
                callback(.success(sc: [PhotoInfo(id: "1", author: "Author", width: 100, height: 100, url: "", downloadUrl: "")]))
            } else {
                callback(.failure(error: ResponseStatus()))
            }
        }
    
    func savePhotoList(photoInfoList: [PhotoInfo], completion: @escaping (Bool) -> Void) {
        didCallSavePhotoList = true
        completion(true)
    }
    
    func fetchAllPhotos(completion: @escaping ([PhotoInfo]) -> Void) {
        didCallFetchAllPhotos = true
        completion([PhotoInfo(id: "1", author: "Author", width: 100, height: 100, url: "", downloadUrl: "")])
    }
    
    func fetchRandomPhoto(index: Int, completion: @escaping (PhotoInfo?, Int) -> Void) {
        didCallFetchRandomPhoto = true
        completion(PhotoInfo(id: "1", author: "Author", width: 100, height: 100, url: "", downloadUrl: ""), index)
    }
    
    func removeAllPhoto() {
        didCallRemoveAllPhoto = true
    }
}

// Unit test class
class PicSaverPresenterImplTests: XCTestCase {
    
    var presenter: PicSaverPresenterImpl!
    var mockViewControllerUpdater: MockViewControllerUpdater!
    var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        LightSpeedCore.getInstance().initSDK(apiGwURl: "https://picsum.photos/")
        mockViewControllerUpdater = MockViewControllerUpdater()
        mockInteractor = MockInteractor()
        presenter = PicSaverPresenterImpl(uiUpdateDelegate: mockViewControllerUpdater)
        presenter.interactor = mockInteractor
    }
    
    override func tearDown() {
        presenter = nil
        mockViewControllerUpdater = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    func testFetchPhoto() {
        presenter.fetchPhoto()
        XCTAssertTrue(mockInteractor.didCallFetchPhotos, "fetchPhotos() should have been called")
        XCTAssertTrue(mockInteractor.didCallRemoveAllPhoto, "removeAllPhoto() should have been called after fetching photos")
        XCTAssertTrue(mockInteractor.didCallSavePhotoList, "savePhotoList() should have been called after removing all photos")
        XCTAssertTrue(mockInteractor.didCallFetchRandomPhoto, "fetchRandomPhoto() should have been called after saving the photo list")
        XCTAssertTrue(mockViewControllerUpdater.didCallReplaceNewDataInDataSource, "replaceNewDataInDataSource() should have been called after fetching a random photo")
    }
    
    func testOnAddButtonPressed() {
        presenter.onAddButtonPressed()
        XCTAssertTrue(mockViewControllerUpdater.didCallAppendNewDataInDataSource, "appendNewDataInDataSource() should have been called when the add button is pressed")
    }
    
    func testCollectionViewUiLoaded() {
        presenter.collectionViewUiLoaded()
        XCTAssertTrue(mockInteractor.didCallFetchRandomPhoto, "fetchRandomPhoto() should have been called when the collection view UI is loaded")
        XCTAssertTrue(mockViewControllerUpdater.didCallReplaceNewDataInDataSource, "replaceNewDataInDataSource() should have been called after fetching a random photo")
    }
    
    func testOnDeleteButtonPressed() {
        let indexPath = IndexPath(item: 0, section: 0)
        presenter.onDeleteButtonPressed(indexPath: indexPath)
        XCTAssertTrue(mockViewControllerUpdater.didCallDeleteDataInDataSource, "deleteDataInDataSource() should have been called when the delete button is pressed")
    }
}
