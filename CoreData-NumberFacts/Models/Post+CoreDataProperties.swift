//
//  Post+CoreDataProperties.swift
//  CoreData-NumberFacts
//
//  Created by Brendon Crowe on 5/3/23.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var title: String?
    @NSManaged public var number: Double
    @NSManaged public var location: String?
    @NSManaged public var user: User?

}

extension Post: Identifiable {

}
