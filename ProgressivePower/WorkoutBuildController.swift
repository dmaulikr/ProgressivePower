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
    let WorkoutBuildTableCellIdentifier = "WorkoutBuildTableCell"
    let firstCellHeight = 44 as CGFloat
    
    var workoutName : String?
    
    //MARK : Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTableView()
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
    
    func setupTableView(){
        self.tableView.registerNib(UINib.init(nibName: WorkoutBuildTableCellIdentifier, bundle: nil), forCellReuseIdentifier: WorkoutBuildTableCellIdentifier)
        self.tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
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
        let cell : WorkoutBuildTableCell
       
        if indexPath.row == 0{
            let firstCell = UITableViewCell(style: .Default, reuseIdentifier: "normalCell")
            firstCell.textLabel?.text = "Add exercise"
            return firstCell
        }
        else{
            cell = self.tableView.dequeueReusableCellWithIdentifier(WorkoutBuildTableCellIdentifier, forIndexPath: indexPath) as! WorkoutBuildTableCell
            cell.configureCellWithExercise(workout().exercises[indexPath.row - 1])
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            self.performSegueWithIdentifier(AddExerciseSegueIdentifier, sender: self)
        } else{
            
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return firstCellHeight
        } else{
            return WorkoutBuildTableCell.cellHeight()
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
