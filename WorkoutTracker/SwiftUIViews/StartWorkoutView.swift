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
    @State var exerciseTimes = [Date](repeating: Calendar.current.date(byAdding: .second, value: 30, to: Date())!, count: Workout.count)
    @State var exercisePause = [Double](repeating: 30.0, count: Workout.count)
    let height = UIScreen.main.bounds.size.height
    @State private var contentOffset: CGPoint = .zero
    var closeDate = Date(timeIntervalSinceNow: 60.0)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    @State var timeRemaining: Date = Date(timeIntervalSinceNow: 30)
    @State var currentIndex = 0
    
    @State private var exerciseTime = Calendar.current.date(byAdding: .second, value: 15, to: Date())!
    @StateObject private var timer = TimerViewModel()
    
    func determineTime(time:Double) -> Date {
        let timeLeft = Date(timeIntervalSinceNow: time)
        return timeLeft
    }
    
    func startTracker() {
        currentIndex = 0
        workoutColours[0] = .white
        for n in 0...workout.count-1 {
            exerciseTimes[n] = Calendar.current.date(byAdding: .second, value: Int(((workout[n] as! Exercise).time)), to: Date())!
        }
        exerciseTime = exerciseTimes[currentIndex]
        for n in 0...workout.count-1 {
            exercisePause[n] = ((workout[n] as! Exercise).rest)
        }
        buttonStates[workout.count-1] = "Finish"
    }
    
    func nextExercise(function: String) {
        if(function == "Next Exercise"){
            currentIndex = currentIndex + 1;
            workoutColours[currentIndex] = .white
            exerciseTime =  Calendar.current.date(byAdding: .second, value: Int(((workout[currentIndex] as! Exercise).time)), to: Date())!
            timer.start(endDate: exerciseTime)
            if(height == 896) {
                self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y + (height-335))
            } else if(height == 844.0) {
                self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y + (height-285))
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
                                    }
                                }
                            }
                        }
                    }
                }.gesture(
                    DragGesture().onChanged { value in
                       if value.translation.height > 0 {
                          print("Scroll down")
                        if value.translation.height > 8 {
                            if(currentIndex != workout.count-1){
                                currentIndex = currentIndex + 1
                            }
                        }
                       } else {
                          print("Scroll up")
                        if value.translation.height > -12 {
                            if(currentIndex < 0){
                                currentIndex - 1
                            }
                         }
                       }
                    }
                 )
            }
            
        }.onAppear {
            startTracker()}
        
        VStack {
                   Group {
                       if timer.currentDate < exerciseTime {
                               Text(exerciseTime, style: .relative)
                           } else {
                            Text("0 sec").onAppear(perform: {
                                if(currentIndex <= workout.count){
                                    nextExercise( function: "Next Exercise")
                                } else  {
                                    nextExercise( function: "Finish")
                                }
                              
                            })
                               }
                           }
                           .foregroundColor(.black)
                           .font(.largeTitle)
                           .padding(.top, 30)
                           .onAppear {
                               timer.start(endDate: exerciseTime)
                           }
                   
                   Button(action: {nextExercise(function: buttonStates[currentIndex])
                   }) {
                       Text(buttonStates[currentIndex]).foregroundColor(.white)
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
