//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Lucas Goldner on 29.12.20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var StartStyle: UIButton!
    @IBAction func StartButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeThingsFancy()
    }

    func makeThingsFancy() {
        StartStyle.layer.cornerRadius = CGFloat(22)
    }
}

