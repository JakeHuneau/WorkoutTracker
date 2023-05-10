//
//  Exercise+CoreDataProperties.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/27/23.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var sets: NSSet?
    
    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedSets: [WorkoutSet] {
        let set = sets as? Set<WorkoutSet> ?? []
        
        return set.sorted {
            $0.created < $1.created
        }
    }

}

// MARK: Generated accessors for sets
extension Exercise {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: WorkoutSet)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: WorkoutSet)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}

extension Exercise : Identifiable {

}
