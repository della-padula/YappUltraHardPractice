//
//  FeedArray+CoreDataProperties.swift
//  
//
//  Created by ITlearning on 2021/09/24.
//
//

import Foundation
import CoreData


extension FeedArray {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedArray> {
        return NSFetchRequest<FeedArray>(entityName: "FeedArray")
    }

    @NSManaged public var userImage: Data?
    @NSManaged public var userName: String?
    @NSManaged public var text: String?
    @NSManaged public var like: Int16
    @NSManaged public var uploadImage: Data?
    @NSManaged public var time: Date?
    @NSManaged public var feedArray: FeedArray?

}
