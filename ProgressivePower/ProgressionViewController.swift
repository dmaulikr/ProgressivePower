//
//  ProgressionViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift

class ProgressionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let allWorkouts = realm.objects(Workout.self)
        let testWorkout = allWorkouts.first
        
        let testWorkoutHistoryLogs = realm.objects(WorkoutHistoryLog.self).filter("")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
