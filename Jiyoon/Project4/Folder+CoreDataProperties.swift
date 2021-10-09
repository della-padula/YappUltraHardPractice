//
//  Folder+CoreDataProperties.swift
//  
//
//  Created by 박지윤 on 2021/10/09.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var folderName: String?
    @NSManaged public var folderLocation: String?
    @NSManaged public var id: Int64

}
