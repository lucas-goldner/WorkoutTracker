//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 29.12.20.
//

import SwiftUI

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
                ForEach((1...10).reversed(), id: \.self) {
                    Text("\($0)…").foregroundColor(.white)
                }
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
