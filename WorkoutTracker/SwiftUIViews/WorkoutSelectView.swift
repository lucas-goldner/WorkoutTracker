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
    var time: Double
    var rest: Int
}

let Workout = [
    Exercise(name: "Pull-up", reps: 10, time: 45.0, rest: 45),
    Exercise(name: "Push-up", reps: 10, time: 30.0, rest: 45),
    Exercise(name: "Sit-up", reps: 20, time: 60.0, rest: 45),

]

struct DetailView : View {
    let value: String

    var body : some View {
        Text("Full View: \(value)")
    }
}

struct WorkoutSelectView: View {
    var body: some View {
        NavigationView {
            ZStack {
            Color.black.ignoresSafeArea()
            VStack{
                Text("Current Workout").font(.title).foregroundColor(.white)
                Text("Back Workout").foregroundColor(.white)
                Spacer()
                Image("workout").cornerRadius(30)
                Spacer()
                ForEach(0 ..< Workout.count) { value in
                    Text(Workout[value].name).foregroundColor(.white)
                }
                Spacer()
                NavigationLink(destination: StartWorkoutView(workout: Workout),
                label: { Text("Start Workout").frame(width: 200 , height: 50, alignment: .center) }).background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
            }
        }
    }
}
}

func hey() {
    print("hey")
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSelectView()
    }
}
