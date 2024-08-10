//
//  ApiPhotoInfo.swift
//  
//
//  Created by Sanjay Dey on 10/8/24.
//

import Foundation

class ApiPhotoInfo: BaseResponse {
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var downloadUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
    
    init(id: String, author: String, width: Int, height: Int, url: String, downloadUrl: String) {
        super.init()
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.downloadUrl = downloadUrl
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.width = try container.decodeIfPresent(Int.self, forKey: .width)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.downloadUrl = try container.decodeIfPresent(String.self, forKey: .downloadUrl)
        try super.init(from: decoder)
    }
    
 }
