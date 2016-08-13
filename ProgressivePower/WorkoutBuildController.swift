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
    
    let AddExerciseSegueIdentifier = "addExercise"
    
    var workoutName : String?
    
    //MARK : Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        print(workoutName)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNav(){
        if let name = workoutName{
            self.title = name
        }
    }
    
    func workout() -> Workout{
        if let name = workoutName{
            let realm = try! Realm()
            let workout = realm.objects(Workout.self).filter("name = '\(name)'")
            if let first = workout.first{
                return first
            }
        }
        return Workout()
    }
    
    // MARK : Table View Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout().exercises.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "WorkoutBuildCell")
        if indexPath.row == 0{
            cell.textLabel?.text = "Add exercise"
        }
        else{
            cell.textLabel?.text = workout().exercises[indexPath.row - 1].name
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            self.performSegueWithIdentifier(AddExerciseSegueIdentifier, sender: self)
        } else{
            
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == AddExerciseSegueIdentifier {
            let destVC = segue.destinationViewController as! AddExerciseController
            destVC.workout = workout()
        }
        // Get the new view controller using segue.destinationViewController.
    }
 

}
