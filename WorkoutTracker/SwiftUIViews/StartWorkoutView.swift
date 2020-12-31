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
                    ForEach(0 ..< Workout.count) { value in
                        Rectangle().frame(width: 10, height: CGFloat(workout.count)*20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(50).foregroundColor(.gray)
                    }
                }
                
                ScrollableView(self.$contentOffset, animationDuration: 0.5) {
                    VStack(spacing: 5) {
                            VStack {
                                HStack(alignment: .center, spacing: -250) {
                                    Spacer()
                                    VStack {
                                        ForEach(0 ..< Workout.count) { value in
                                            Text((workout[value] as! Exercise).name).foregroundColor(.white)
                                        }
                                    }
                                    Spacer()
                                    Spacer()
                                    VStack{
                                        Button(action: {
                                           print("question")
                                        }) {
                                            Image("question").scaleEffect(CGSize(width: 0.4, height: 0.4))
                                        }
                                        Button(action: {
                                           print("cancel")
                                        }) {
                                            Image("cancel").scaleEffect(CGSize(width: 0.2, height: 0.2)).colorInvert()
                                        }
                                      
                                    }
                                    
                                }
                                
                                
                                Image("workout")
                                Button(action: {
                                    self.contentOffset = CGPoint(x: 0, y: 100)
                                }) {
                                    Text("scroll to bottom")
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
}

struct StartWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        StartWorkoutView(workout: [Exercise(name: "Pull-up", reps: 10, time: 45),
        Exercise(name: "Push-up", reps: 10, time: 30),
        Exercise(name: "Sit-up", reps: 20, time: 60),])
    }
}
