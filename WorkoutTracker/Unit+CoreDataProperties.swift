//
//  Unit+CoreDataProperties.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/27/23.
//
//

import Foundation
import CoreData


extension Unit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Unit> {
        return NSFetchRequest<Unit>(entityName: "Unit")
    }

    @NSManaged public var name: String?
    @NSManaged public var sets: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedSets: [WorkoutSet] {
        let set = sets as? Set<WorkoutSet> ?? []
        
        return set.sorted {
            $0.created < $1.created
        }
    }

}

// MARK: Generated accessors for sets
extension Unit {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: WorkoutSet)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: WorkoutSet)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}

extension Unit : Identifiable {
    
}
