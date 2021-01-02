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

struct StartWorkoutView: View {
    let workout: Array<Any>
    let height = UIScreen.main.bounds.size.height
    @State private var contentOffset: CGPoint = .zero
    var closeDate = Date(timeIntervalSinceNow: 60.0)
    
    func determineTime(time:Double) -> Date {
        let timeLeft = Date(timeIntervalSinceNow: time)
        return timeLeft
    }
    
    func startTracker() {
        print("Yo")
    }
    
    func nextExercise() {
        print(height)
        if(height == 896) {
            self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y + (height-170))
        } else if(height == 844.0) {
            self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y + (height-100))
        }
    }
    
    func eachSecond() {
//      seconds += 1
//      updateDisplay()
    }
    
//    private func updateDisplay() {
//      let formattedDistance = FormatDisplay.distance(distance)
//      let formattedTime = FormatDisplay.time(seconds)
//      let formattedPace = FormatDisplay.pace(distance: distance,
//                                             seconds: seconds,
//                                             outputUnit: UnitSpeed.minutesPerMile)
//
//      distanceLabel.text = "\(formattedDistance)"
//      timeLabel.text = "\(formattedTime)"
//      paceLabel.text = "\(formattedPace)"
//    }
    
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
                        Rectangle().frame(width: 10, height: barHeight(bars: workout.count), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(50).foregroundColor(.gray)
                    }
                }.padding(.top, -50)
                
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
                                       
                                        Text(determineTime(time: ((workout[value] as! Exercise).time)), style: .relative).foregroundColor(.white).font(.largeTitle).padding(.top, 30)
                                        Button(action: {nextExercise()
                                        }) {
                                            Text("Next Exercise").foregroundColor(.white)
                                        }.padding(.all, 20).padding(.horizontal, 80).background(Color.green).cornerRadius(20)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear {
        startTracker()}
    }
}

struct StartWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        StartWorkoutView(workout: [Exercise(name: "Pull-up", reps: 10, time: 45.0, rest: 45),
                                   Exercise(name: "Push-up", reps: 10, time: 30.0, rest: 45),
                                   Exercise(name: "Sit-up", reps: 20, time: 60.0, rest: 45),
        ])
    }
}

