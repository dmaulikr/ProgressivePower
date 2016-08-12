//
//  ProgressionViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift
import Charts
import ChameleonFramework

class ProgressionViewController: UIViewController, ChartViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let realm = try! Realm()
        let allWorkouts = realm.objects(Workout.self)
        let testWorkout = allWorkouts.first
        let testWorkoutName = testWorkout?.name
        let testWorkoutHistoryLogs = realm.objects(WorkoutHistoryLog.self).filter("name = '\(testWorkoutName)'")
        
        var workoutDateArray : [NSDate] = []
        for log in testWorkoutHistoryLogs{
            workoutDateArray.append(log.date)
        }
        
        let length = testWorkoutHistoryLogs.count
        let logLength = (length == 0) ? 0 : testWorkoutHistoryLogs[0].exerciseLogs.count
        
        for i in 0..<logLength{
            var weightArray : [Double] = []
            for j in 0..<length{
                weightArray.append(testWorkoutHistoryLogs[j].exerciseLogs[i].weight)
            }
        
        }
        
        let chart = LineChartView(frame: CGRectMake(0,0,self.view.frame.size.width, 300));
        chart.center = self.view.center
        chart.delegate = self
        chart.descriptionText = ""
        chart.noDataText = "No exercise data available."
        chart.noDataTextDescription = "Complete at least one workout to see your results."
        chart.drawBordersEnabled = false
        self.view.addSubview(chart);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
