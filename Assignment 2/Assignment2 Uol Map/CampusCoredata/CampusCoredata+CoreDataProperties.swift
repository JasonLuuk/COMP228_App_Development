//
//  CampusCoredata+CoreDataProperties.swift
//  Assignment2 Uol Map
//
//  Created by Jason on 11/12/2021.
//
//

import Foundation
import CoreData


extension CampusCoredata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CampusCoredata> {
        return NSFetchRequest<CampusCoredata>(entityName: "CampusCoredata")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var like: String?
    @NSManaged public var enabled: String?
    @NSManaged public var lastModified: String?
    @NSManaged public var thumbnail: URL?
    @NSManaged public var imgefileName: String?
    @NSManaged public var locationNotes: String?
    @NSManaged public var location: String?
    @NSManaged public var long: String?
    @NSManaged public var lat: String?
    @NSManaged public var information: String?
    @NSManaged public var type: String?
    @NSManaged public var yearOfWork: String?
    @NSManaged public var artist: String?

}

extension CampusCoredata : Identifiable {

}
