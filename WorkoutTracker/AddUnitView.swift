//
//  AddUnitView.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/28/23.
//

import Foundation
import SwiftUI

struct AddUnitView: View {
    @Environment(\.managedObjectContext) var moc
    
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
                    TextField("Unit Name", text: $name)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                }
                .scrollContentBackground(.hidden)
                
                Button("Save") {
                    let unit = Unit(context: self.moc)
                    unit.name = name.lowercased()
                    
                    do {
                        try self.moc.save()
                    } catch {
                        print("Couldn't save unit: \(error)")
                    }
                    
                    withAnimation {
                        onSave()
                    }
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

struct AddUnitView_Previews: PreviewProvider {
    static var previews: some View {
        AddUnitView(
            onSave: {print("Saved")}
        )
    }
}
