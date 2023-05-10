//
//  AddWorkoutSetView.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/30/23.
//

import Foundation
import SwiftUI

struct AddWorkoutSetView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var units: FetchedResults<Unit>
    
    let onSave: () -> Void
    
    init(onSave: @escaping () -> Void) {
        self.onSave = onSave
    }
    
    @State private var exerciseIndex = 0
    @State private var weight = ""
    @State private var unitIndex = 0
    @State private var reps = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Form {
                    Picker("Exercise Type", selection: $exerciseIndex) {
                        ForEach(0..<exercises.count, id: \.self) { index in
                            Text(exercises[index].wrappedName)
                        }
                    }
                    
                    HStack {
                        Text("Weight")
                        
                        Spacer()
                        
                        TextField("Weight", text: $weight)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("Unit", selection: $unitIndex) {
                        ForEach(0..<units.count, id: \.self) { index in
                            Text(units[index].wrappedName)
                        }
                    }
                    
                    HStack {
                        Text("Reps")
                        
                        Spacer()
                        
                        TextField("Reps", text: $reps)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    TextField("Notes", text: $notes)
                }
                .scrollContentBackground(.hidden)
                
                Button("Save") {
                    let set = WorkoutSet(context: self.moc)
                    set.exercise = exercises[exerciseIndex]
                    set.weight = Int16(weight) ?? 0
                    set.unit = units[unitIndex]
                    set.count = Int16(reps) ?? 0
                    set.notes = notes
                    set.created = Int32(Date().timeIntervalSince1970)
                    
                    do {
                        try self.moc.save()
                    } catch {
                        print("Couldn't save unit: \(error)")
                    }
                    
                    onSave()
                }
                .offset(y: -20)
            }
        }
        .frame(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height * 0.5
        )
        .background(.white)
        .transition(.move(edge: .top))
    }
}

struct AddWorkoutSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutSetView(
            onSave: {print("Saved")}
        )
    }
}
