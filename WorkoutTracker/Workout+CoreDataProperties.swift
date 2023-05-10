//
//  Workout+CoreDataProperties.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/27/23.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var date: Date?
    @NSManaged public var notes: String?
    @NSManaged public var sets: NSSet?
    
    public var wrappedDate: Date {
        date ?? Date.distantPast
    }
    
    public var wrappedNotes: String {
        notes ?? ""
    }
    
    public var wrappedSets: [WorkoutSet] {
        let set = sets as? Set<WorkoutSet> ?? []
        
        return set.sorted {
            $0.created < $1.created
        }
    }

}

// MARK: Generated accessors for sets
extension Workout {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: WorkoutSet)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: WorkoutSet)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}

extension Workout : Identifiable {

}
