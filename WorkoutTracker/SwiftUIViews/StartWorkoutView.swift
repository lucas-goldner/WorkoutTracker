//
//  StartWorkoutView.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 30.12.20.
//
//
//                                Button(action: {
//                                    self.contentOffset = CGPoint(x: 0, y: 100)
//                                }) {
//                                    Text("scroll to bottom")
//                                }
//
//                                Button(action: {
//                                    self.contentOffset = CGPoint(x: 0, y: 0)
//                                }) {
//                                    Text("scroll to top")
//                                }

import SwiftUI
import UIKit

struct StartWorkoutView: View {
    let workout: Array<Any>
    @State var workoutColours = [Color](repeating: .gray, count: Workout.count)
    @State var buttonStates = [String](repeating: "Next Exercise", count: Workout.count)
    //@State var exerciseTime = [Date](repeating: Date(timeIntervalSinceNow: 30), count: Workout.count)
    @State var exercisePause = [Double](repeating: 30.0, count: Workout.count)
    let height = UIScreen.main.bounds.size.height
    @State private var contentOffset: CGPoint = .zero
    var closeDate = Date(timeIntervalSinceNow: 60.0)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    @State var timeRemaining: Date = Date(timeIntervalSinceNow: 30)
    
    var currentIndex = 0
    @State private var exerciseTime = Calendar.current.date(byAdding: .second, value: 15, to: Date())!
    @StateObject private var timer = TimerViewModel()
    
    func determineTime(time:Double) -> Date {
        let timeLeft = Date(timeIntervalSinceNow: time)
        return timeLeft
    }
    
    func startTracker() {
        buttonStates[workout.count-1] = "Finish"
//        for n in 0...workout.count-1 {
//            exerciseTime[n] = determineTime(time: ((workout[n] as! Exercise).time))
//        }
        for n in 0...workout.count-1 {
            exercisePause[n] = ((workout[n] as! Exercise).rest)
        }
        
        
        
//        for n in 0...exercises-1 {
//            timeRemaining = determineTime(time: exerciseTime[n])
//        }
//        timeRemaining = determineTime(time: exerciseTime[0])
//        if timeRemaining.timeIntervalSinceNow > 0 {
//            print("working")
//        } else {
//            print("done")
//        }
    }
    
    func nextExercise(index: Int, function: String) {
        if(function == "Next Exercise"){
            workoutColours[index] = .white
            if(index==workout.count-2){
                workoutColours[workout.count-1] = .white
            }
            if(height == 896) {
                self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y + (height-170))
            } else if(height == 844.0) {
                self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y + (height-100))
            }
        } else {
            guard let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.switchBack()
            print("Finish")
        }
    }
    
    func barHeight(bars: Int) -> CGFloat {
        if(bars<=3){
            return 60;
        } else if(bars<=10) {
            return 30;
        } else {
            return 20;
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            HStack {
                VStack {
                    ForEach(0 ..< Workout.count) { value in
                        Rectangle().frame(width: 10, height: barHeight(bars: workout.count), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(50).foregroundColor(workoutColours[value])
                    }
                }.padding(.top, -150)
                
                ScrollableView(self.$contentOffset, animationDuration: 0.5) {
                    VStack(spacing: 5) {
                        VStack {
                            LazyVStack(spacing: 170) {
                                ForEach(0 ..< Workout.count) { value in
                                    VStack(spacing: 30){
                                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                                            VStack(spacing: 20) {
                                                Text((workout[value] as! Exercise).name).font(.system(size: 60)).foregroundColor(.white)
                                                HStack {
                                                    Text(String((workout[value] as! Exercise).reps)).foregroundColor(.white)
                                                    Text((workout[value] as! Exercise).name).foregroundColor(.white)
                                                }
                                            }
                                            VStack(spacing: 0){
                                                Button(action: {print("question")
                                                }) {
                                                    Image("question").scaleEffect(CGSize(width: 0.4, height: 0.4))
                                                }
                                                Button(action: {
                                                    print("cancel")
                                                }) {
                                                    Image("cancel").scaleEffect(CGSize(width: 0.2, height: 0.2)).colorInvert()
                                                }
                                                
                                            }.padding(.trailing, -110)
                                        }
                                        Image("workout").cornerRadius(20).scaleEffect(CGSize(width: 1.3, height: 1.3))
                                        
                                        if currentIndex == value {
                                            
                                        } else {
                                            
                                        }
                                        
                                      
                                        
                                      
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }.onAppear {
            startTracker()}
        VStack {
            Group {
                if timer.currentDate < exerciseTime {
                        Text(exerciseTime, style: .relative)
                    } else {
                        Text("0 sec")
                        }
                    }
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .padding(.top, 30)
                    .onAppear {
                        timer.start(endDate: exerciseTime)
                    }
            
            Button(action: {nextExercise(index: 0, function: buttonStates[0])
            }) {
                Text(buttonStates[0]).foregroundColor(.white)
            }.padding(.all, 20).padding(.horizontal, 80).background(Color.green).cornerRadius(20)
        }
        
       
    }
}

struct StartWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        StartWorkoutView(workout: [Exercise(name: "Pull-up", reps: 10, time: 45.0, rest: 45.0),
                                   Exercise(name: "Push-up", reps: 10, time: 30.0, rest: 45.0),
                                   Exercise(name: "Sit-up", reps: 20, time: 60.0, rest: 45.0),
        ])
    }
}
