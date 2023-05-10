//
//  WorkoutSet+CoreDataProperties.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/27/23.
//
//

import Foundation
import CoreData


extension WorkoutSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutSet> {
        return NSFetchRequest<WorkoutSet>(entityName: "WorkoutSet")
    }

    @NSManaged public var count: Int16
    @NSManaged public var notes: String?
    @NSManaged public var created: Int32
    @NSManaged public var weight: Int16
    @NSManaged public var exercise: Exercise?
    @NSManaged public var unit: Unit?
    @NSManaged public var workout: Workout?
    
    public var wrappedNotes: String {
        notes ?? ""
    }

}

extension WorkoutSet : Identifiable {

}
