//
//  Weather+CoreDataProperties.swift
//  
//
//  Created by 박지윤 on 2021/09/25.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var location: String?
    @NSManaged public var temp: Double
    @NSManaged public var tempMax: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var time: String?

}
