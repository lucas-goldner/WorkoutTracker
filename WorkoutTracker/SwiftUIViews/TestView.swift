//
//  TestView.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 04.01.21.
//

import SwiftUI

struct TestView: View {
    @State private var exerciseTime = Calendar.current.date(byAdding: .second, value: 15, to: Date())!
    @StateObject private var timer = TimerViewModel()
    
    var body: some View {
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
            
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
