//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 29.12.20.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var StartStyle: UIButton!
    @IBAction func StartButton(_ sender: Any) {
    }
    
    @IBSegueAction func swiftUIAction(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: WorkoutSelectView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeThingsFancy()
    }

    func makeThingsFancy() {
        StartStyle.layer.cornerRadius = CGFloat(22)
    }
}

