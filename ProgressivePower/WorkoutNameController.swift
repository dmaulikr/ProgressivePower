//
//  WorkoutNameController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/30/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift

class WorkoutNameController: UIViewController {
    
    let BuildWorkoutSegueIdentifier = "buildWorkout"

    var nameToPass: String?
    
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNav(){
        self.title = "Create Workout"
    }
    
    @IBAction func createWorkoutPressed(sender: AnyObject) throws {
        do{
            try createWorkout()
        } catch PPError.DBFail{
            Algorithm.presentErrorAlertWithMessage("Save failure.  Please try again.", sender: self)
        } catch PPError.DuplicateValue{
            Algorithm.presentErrorAlertWithMessage("You already have a workout with that name.  Pick another one.", sender: self)
        } catch PPError.NoValue{
            Algorithm.presentErrorAlertWithMessage("You need to specify a name!", sender: self)
        }

    }
    
    func createWorkout() throws{
        guard let text = nameField.text else{
            throw PPError.NoValue
        }
        let realm = try! Realm()
        let workouts = realm.objects(Workout.self).filter("name = '\(text)'")
        guard workouts.count == 0 else{
            throw PPError.DuplicateValue
        }
        let workout = Workout()
        workout.name = text
        nameToPass = text
        
        realm.beginWrite()
        do{
            try realm.commitWrite()
        } catch{
            throw PPError.DBFail
        }
        self.performSegueWithIdentifier(BuildWorkoutSegueIdentifier, sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == BuildWorkoutSegueIdentifier{
            let destVC = segue.destinationViewController as! WorkoutBuildController
            destVC.workoutName = nameToPass
        }
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
