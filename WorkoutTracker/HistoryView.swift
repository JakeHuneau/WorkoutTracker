//
//  HistoryView.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 4/3/23.
//

import Foundation
import SwiftUI


struct HistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var workouts: FetchedResults<Workout>
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(workouts, id: \.self) { workout in
                        NavigationLink {
                            WorkoutDetails(workout: workout)
                        } label: {
                            Text(workout.wrappedDate, style: .date)
                        }
                    }
                }
            }
        }
    }
}

struct WorkoutDetails: View {
    @State private var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    var body: some View {
        VStack {
            List() {
                ForEach(workout.wrappedSets, id: \.self) { workoutSet in
                    if workoutSet.wrappedNotes.isEmpty {
                        Text("\(workoutSet.exercise!.wrappedName) - \(workoutSet.weight) \(workoutSet.unit!.wrappedName) - \(workoutSet.count) reps")
                    } else {
                        Label {
                            Text("\(workoutSet.exercise!.wrappedName) - \(workoutSet.weight) \(workoutSet.unit!.wrappedName) - \(workoutSet.count) reps")
                        } icon: {
                            Image(systemName: "book")
                        }
                        .labelStyle(TrailingIconLabelStyle())
                    }
                }
            }
        }
    }
}

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            Spacer()
            configuration.icon
        }
    }
}
