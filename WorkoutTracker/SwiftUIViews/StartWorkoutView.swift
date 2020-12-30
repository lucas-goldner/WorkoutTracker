//
//  StartWorkoutView.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 30.12.20.
//

import SwiftUI

struct StartWorkoutView: View {
    let workout: Array<Any>
    
    var body: some View {
        ForEach(0 ..< Workout.count) { value in
            Text((workout[value] as! Exercise).name).foregroundColor(.black)
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
