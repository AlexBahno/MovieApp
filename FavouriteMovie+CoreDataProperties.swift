//
//  FavouriteMovie+CoreDataProperties.swift
//  
//
//  Created by Alexandr Bahno on 03.02.2024.
//
//

import Foundation
import CoreData


extension FavouriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovie> {
        return NSFetchRequest<FavouriteMovie>(entityName: "FavouriteMovie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var genre: String?
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var rating: Double
    @NSManaged public var image: String?

}
