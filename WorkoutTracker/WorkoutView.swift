//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/28/23.
//

import Foundation
import SwiftUI

struct WorkoutView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.created)], predicate: NSPredicate(format: "workout == nil")) var sets: FetchedResults<WorkoutSet>
    
    @State var isSlideOpen = false
    @State var inWorkout = false
    @State var isAddSet = false
    
    @State private var notes = ""

    var body: some View {
        ZStack {
            NavigationStack {
                if inWorkout {
                    workoutView
                } else {
                    startWorkoutButton
                }
            }
            WorkoutTopbar(isSlideOpen: self.$isSlideOpen, isAddSet: self.$isAddSet)
        }
    }
    
    var startWorkoutButton: some View {
        Button(action: {
            self.inWorkout.toggle()
        }) {
            Text("Start Workout")
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height,
                    alignment: .center
                )
        }
            .padding()
            .toolbar {topBar}
    }
    
    var workoutView: some View {
        VStack {
            Button(action: {
                withAnimation {
                    self.isAddSet.toggle()
                    self.isSlideOpen.toggle()
                }
            }) {
                Text("Add Set")
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(15)
            
            List() {
                ForEach(sets, id: \.self) { workoutSet in
                    Text("\(workoutSet.exercise!.wrappedName) - \(workoutSet.weight) \(workoutSet.unit!.wrappedName) - \(workoutSet.count) reps")
                }
                .onDelete(perform: removeSet)
            }
            .listStyle(.inset)
                
            VStack {
                TextField("Notes", text: $notes)
                    .padding()
                
                Button(action: {
                    let workout = Workout(context: moc)
                    workout.notes = notes
                    workout.date = Date()
                    
                    for workoutSet in sets {
                        workoutSet.workout = workout
                    }
                    
                    notes = ""
                    
                    self.inWorkout.toggle()
                    do {
                        try moc.save()
                    } catch {
                        print("Error saving workout: \(error)")
                    }
                }) {
                    Text("Save Workout")
                }
            }
            .frame(alignment: .bottom)
        }
        .toolbar {topBar}
    }
    
    func removeSet(at offsets: IndexSet) {
        for index in offsets {
            let exerciseSet = sets[index]
            moc.delete(exerciseSet)
        }
    }
    
    var topBar: some View {
        Button(action: {
            withAnimation {
                self.isSlideOpen.toggle()
            }
        }) {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .padding(6)
                .frame(width: 32, height: 32)
//                .foregroundColor(Color.black)
        }
    }
}

struct PopoverView: View {
    var body: some View {
        VStack {
            Text("message").padding()
            Button("Resume") {
                
            }
        }.padding()
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
