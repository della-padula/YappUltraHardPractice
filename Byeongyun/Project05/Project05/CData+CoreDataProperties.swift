//
//  CData+CoreDataProperties.swift
//  
//
//  Created by ITlearning on 2021/10/09.
//
//

import Foundation
import CoreData


extension CData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CData> {
        return NSFetchRequest<CData>(entityName: "CData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var photo: [Data?]

}
