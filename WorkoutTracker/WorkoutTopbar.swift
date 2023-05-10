//
//  WorkoutTopbar.swift
//  WorkoutTracker
//
//  Created by Jake Huneau on 3/28/23.
//

import Foundation
import SwiftUI

struct WorkoutTopbar: View {
    @Binding var isSlideOpen: Bool
    @Binding var isAddSet: Bool
    
    // Give default value to isAddSet
    init(isSlideOpen: Binding<Bool>, isAddSet: Binding<Bool> = .constant(false)) {
        self._isSlideOpen = isSlideOpen
        self._isAddSet = isAddSet
    }
    
    @State private var isAddWorkout = false
    @State private var isAddUnit = false
    
    var slideHeight = UIScreen.main.bounds.size.height * 0.1
    @State var addHeight = UIScreen.main.bounds.size.height * 0.2

    var body: some View {
        ZStack {
            GeometryReader {
                _ in EmptyView()

            }
            .background(.black.opacity(0.6))
            .opacity(isSlideOpen ? 1 : 0)
            .animation(.easeInOut.delay(0.1), value: isSlideOpen)
            .onTapGesture {
                withAnimation {
                    isSlideOpen = false
                    isAddUnit = false
                    isAddWorkout = false
                    isAddSet = false
                }
            }
            
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        VStack {
            if isSlideOpen {
                if isAddSet {
                    AddWorkoutSetView(
                        onSave: {
                            withAnimation {
                                isSlideOpen = false
                                isAddSet = false
                            }
                        }
                    )
                } else if isAddWorkout {
                    AddWorkoutView(
                        onSave: {
                            withAnimation {
                                isSlideOpen = false
                                isAddWorkout = false
                            }
                        }
                    )
                } else if isAddUnit {
                    AddUnitView(
                        onSave: {
                            withAnimation {
                                isSlideOpen = false
                                isAddUnit = false
                            }
                        }
                    )
                } else {
                    menu
                }
            }
            
            Spacer()
        }
    }
    
    var menu: some View {
        HStack {
            Button("Add workout type") {
                withAnimation {
                    self.isAddWorkout.toggle()
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottom
            )
            .offset(y: -10)
            
            Button("Add unit") {
                withAnimation {
                    self.isAddUnit.toggle()
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottom
            )
            .offset(y: -10)
        }
        .frame(
            width: UIScreen.main.bounds.size.width,
            height: slideHeight
        )
        .background(.white)
        .transition(.move(edge: .top))
    }
}

struct WorkoutTopbar_Previews: PreviewProvider {
    
    static var previews: some View {
        WorkoutTopbar(isSlideOpen: .constant(true))
    }
}
