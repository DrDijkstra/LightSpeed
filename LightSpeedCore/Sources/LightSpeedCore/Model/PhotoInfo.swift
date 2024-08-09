import Foundation

class PhotoInfo {
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var downloadUrl: String?
    
    init(id: String, author: String, width: Int, height: Int, url: String, downloadUrl: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.downloadUrl = downloadUrl
    }
    
    init(apiPhotoInfo: ApiPhotoInfo) {
        self.id = apiPhotoInfo.id
        self.author = apiPhotoInfo.author
        self.width = apiPhotoInfo.width
        self.height = apiPhotoInfo.height
        self.url = apiPhotoInfo.url
        self.downloadUrl = apiPhotoInfo.downloadUrl
    }
    
  
}
