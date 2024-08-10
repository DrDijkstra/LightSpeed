import Foundation

public class PhotoInfo {
    public var id: String?
    public var author: String?
    public var width: Int?
    public var height: Int?
    public var url: String?
    public var downloadUrl: String?
    public var heightMultiplier: String?
    
    public init () {
        
    }
    
    public init(id: String, author: String, width: Int, height: Int, url: String, downloadUrl: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.downloadUrl = downloadUrl
        
        let heightMultiplier:Double = Double(height) / Double(width)
        self.heightMultiplier = String(heightMultiplier)
    }
    
    init(apiPhotoInfo: ApiPhotoInfo) {
        self.id = apiPhotoInfo.id
        self.author = apiPhotoInfo.author
        self.width = apiPhotoInfo.width
        self.height = apiPhotoInfo.height
        self.url = apiPhotoInfo.url
        self.downloadUrl = apiPhotoInfo.downloadUrl
        
        let heightMultiplier:Double = Double(apiPhotoInfo.height ?? 0) / Double(apiPhotoInfo.width ?? 1)
        self.heightMultiplier = String(heightMultiplier)
    }
    
  
}
