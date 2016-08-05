//
//  WorkoutBuildController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/30/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift

class WorkoutBuildController: UITableViewController {
    var workoutName : String?
    var workout : Workout{
        get{
            if let name = workoutName{
                let realm = try! Realm()
                let workout = realm.objects(Workout.self).filter("name = '\(name)'")
                if let first = workout.first{
                    return first
                }
                else{
                    return Workout()
                }
            }
            else{
                return Workout()
            }
        }
    }
    var exercises : List<UserExercises>{
        get{
            return workout.exercises
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadSections(NSIndexSet(index: 0) , withRowAnimation: .Automatic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "WorkoutBuildCell")
        cell.textLabel?.text = exercises[indexPath.row].name
        return cell
    }
    func addExercisePressed(){
        self.navigationController?.performSegueWithIdentifier("addExercise", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addExercise" {
            let destVC = segue.destinationViewController as! AddExerciseController
            destVC.workout = self.workout
        }
        // Get the new view controller using segue.destinationViewController.
    }
 

}
