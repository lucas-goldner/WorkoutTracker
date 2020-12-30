//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 29.12.20.
//

import SwiftUI

struct Exercise {
    var name: String
    var reps: Int
    var time: Int
}

let Workout = [
    Exercise(name: "Pull-up", reps: 10, time: 45),
    Exercise(name: "Push-up", reps: 10, time: 30),
    Exercise(name: "Sit-up", reps: 20, time: 60),
]

struct WorkoutView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack{
                Text("Current Workout").font(.title).foregroundColor(.white)
                Text("Back Workout").foregroundColor(.white)
                Spacer()
                Text("Cooles Bild").foregroundColor(.white)
                Spacer()
                ForEach(0 ..< Workout.count) { value in
                    Text(Workout[value].name).foregroundColor(.white)
                }
                Spacer()
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
