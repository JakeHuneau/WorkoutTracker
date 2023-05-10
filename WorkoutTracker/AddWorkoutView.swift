//
//  AddWorkoutView.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/28/23.
//

import Foundation
import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let onSave: () -> Void
    
    init(onSave: @escaping () -> Void) {
        self.onSave = onSave
    }
    
    @State var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Form {
                    TextField("Exercise Name", text: $name)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                }
                .scrollContentBackground(.hidden)
                
                Button("Save") {
                    let exercise = Exercise(context: managedObjectContext)
                    exercise.name = name.lowercased()
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print("Couldn't save exercise")
                    }
                    
                    onSave()
                }
                .offset(y: -20)
            }
        }
        .frame(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height * 0.2
        )
        .background(.white)
        .transition(.move(edge: .top))
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView(
            onSave: {print("Saved")}
        )
    }
}
