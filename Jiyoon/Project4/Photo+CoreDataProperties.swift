//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by 박지윤 on 2021/10/09.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoId: Int64
    @NSManaged public var photoLocation: String?
    @NSManaged public var photoName: String?
    @NSManaged public var image: Data?
    @NSManaged public var folderId: Folder?

}
