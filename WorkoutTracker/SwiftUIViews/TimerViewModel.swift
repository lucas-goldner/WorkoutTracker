//
//  TimerViewModel.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 04.01.21.
//

import Foundation
import Combine
import SwiftUI

class TimerViewModel: ObservableObject {
    private var timer: AnyCancellable?

    @Published var currentDate = Date()

    func start(endDate: Date) {
        timer = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] in
                guard let self = self else { return }
                self.currentDate = $0
                if self.currentDate >= endDate {
                    self.timer = nil
                }
            }
    }
}
