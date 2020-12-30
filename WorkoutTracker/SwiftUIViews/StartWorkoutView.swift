//
//  StartWorkoutView.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 30.12.20.
//

import SwiftUI

struct StartWorkoutView: View {
    let workout: Array<Any>
    @State private var contentOffset: CGPoint = .zero
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            HStack {
                VStack {
                    Text("[]").foregroundColor(.white)
                    Text("[]").foregroundColor(.white)
                    Text("[]").foregroundColor(.white)
                }
                
                ScrollableView(self.$contentOffset, animationDuration: 0.5) {
                    VStack(spacing: 5) {
                       
                        Button(action: {
                            self.contentOffset = CGPoint(x: 0, y: 100)
                        }) {
                            Text("scroll to bottom")
                        }
                        ForEach(0 ..< Workout.count) { value in
                            Text((workout[value] as! Exercise).name).foregroundColor(.white)
                        }
                        Button(action: {
                            self.contentOffset = CGPoint(x: 0, y: 0)
                        }) {
                            Text("scroll to top")
                        }
                    }
                }
                
                
            }
        }
    }
}

struct StartWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        StartWorkoutView(workout: [Exercise(name: "Pull-up", reps: 10, time: 45),
        Exercise(name: "Push-up", reps: 10, time: 30),
        Exercise(name: "Sit-up", reps: 20, time: 60),])
    }
}
