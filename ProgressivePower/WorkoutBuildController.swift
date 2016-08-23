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
    
    override func willMoveToParentViewController(parent:UIViewController?)
    {
        super.willMoveToParentViewController(parent)
        
        if (parent == nil) {
            if let navigationController = self.navigationController {
                var viewControllers = navigationController.viewControllers
                let viewControllersCount = viewControllers.count
                if (viewControllersCount > 2) {
                    viewControllers.removeAtIndex(viewControllersCount - 2)
                    navigationController.setViewControllers(viewControllers, animated:false)
                }
            }
        }
    }

    
    func setupNav(){
        if let name = workoutName{
            self.title = name
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    func setupTableView(){
        self.tableView.registerNib(UINib.init(nibName: WorkoutBuildTableCellIdentifier, bundle: nil), forCellReuseIdentifier: WorkoutBuildTableCellIdentifier)
        self.tableView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        self.tableView.tableFooterView = UIView()
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
            firstCell.accessoryType = .DisclosureIndicator
            return firstCell
        }
        else{
            cell = self.tableView.dequeueReusableCellWithIdentifier(WorkoutBuildTableCellIdentifier, forIndexPath: indexPath) as! WorkoutBuildTableCell
            cell.configureCellWithExercise(workout().exercises[indexPath.row - 1])
            cell.accessoryType = .DisclosureIndicator
            if indexPath.row % 2 == 0{
                cell.highlightView.backgroundColor = Algorithm.currentThemeColor()
            } else {
                cell.highlightView.backgroundColor = UIColor.flatGrayColor()
            }
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
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row != 0{
            return true
        }
        return false
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let realm = try! Realm()
            let exerciseToDelete = workout().exercises[indexPath.row - 1]
            do{
                try realm.write({
                    realm.delete(exerciseToDelete)
                })
            } catch{
                Algorithm.presentErrorAlertWithMessage("Delete error - try again", sender: self)
            }
            self.tableView.reloadSections(NSIndexSet(index:0), withRowAnimation: .Fade)
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
