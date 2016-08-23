//
//  WorkoutDisplayController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 8/21/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift

class WorkoutDisplayController: UITableViewController {

    let NextLiftTableCellIdentifier = "NextLiftTableCell"
    let CreateSegueIdentifier = "createWorkout"
    let BuildWorkoutSegueIdentifier = "buildWorkout"
    let BasicCellHeight = 44 as CGFloat
    
    var selectedCell = 0
    var workouts : Results<Workout>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        workouts = allWorkouts()
        setupNav()
        setupTable()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func allWorkouts() -> Results<Workout>{
        let realm = try! Realm()
        return realm.objects(Workout.self)
    }
    
    func setupNav(){
        self.title = "Plan"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setupTable(){
        self.tableView.registerNib(UINib(nibName: NextLiftTableCellIdentifier, bundle: nil), forCellReuseIdentifier: NextLiftTableCellIdentifier)
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let workouts = workouts{
            return workouts.count + 1
        } else{
            return 1
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "First")
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.textColor = UIColor.flatBlackColor()
            cell.textLabel?.text = "New Workout"
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NextLiftTableCellIdentifier, forIndexPath: indexPath) as! NextLiftTableCell
        if let workouts = workouts{
            cell.configureCellForWorkout(workouts[indexPath.row - 1])
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            self.performSegueWithIdentifier(CreateSegueIdentifier, sender: self)
        } else{
            selectedCell = indexPath.row
            self.performSegueWithIdentifier(BuildWorkoutSegueIdentifier, sender: self)
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != 0{
            return 120
        }
        else {
            return BasicCellHeight
        }
    }
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == BuildWorkoutSegueIdentifier{
            let buildVC = segue.destinationViewController as! WorkoutBuildController
            buildVC.workoutName = allWorkouts()[selectedCell - 1].name
        }
    }

}