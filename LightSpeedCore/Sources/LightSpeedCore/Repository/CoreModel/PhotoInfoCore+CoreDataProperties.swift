//
//  PhotoInfoCore+CoreDataProperties.swift
//  LSPicSaver
//
//  Created by Sanjay Dey on 10/8/24.
//
//

import Foundation
import CoreData


extension PhotoInfoCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoInfoCore> {
        return NSFetchRequest<PhotoInfoCore>(entityName: "PhotoInfoCore")
    }

    @NSManaged public var id: String?
    @NSManaged public var width: Int64
    @NSManaged public var height: Int64
    @NSManaged public var authorName: String?
    @NSManaged public var downloadUrl: String?
    @NSManaged public var url: String?

}

extension PhotoInfoCore : Identifiable {

}
