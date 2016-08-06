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

    var nameToPass: String?
    
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func createWorkoutPressed(sender: AnyObject) {
        if let text = nameField.text{
            let realm = try! Realm()
            let workouts = realm.objects(Workout.self).filter("name = '\(text)'")
            if workouts.count == 0 {
                //Save to realm
                let workout = Workout()
                workout.name = text
                
                nameToPass = text
                
                let realm = try! Realm()
                try! realm.write({
                    realm.add(workout)
                })
                self.navigationController?.performSegueWithIdentifier("buildWorkout", sender: self)
            } else{
                duplicateError()
            }
        } else{
            noNameError()
        }
    }
    
    func noNameError(){
        let controller = Algorithm.errorAlertWithMessage("You didn't specify a name!")
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func duplicateError(){
        let controller = Algorithm.errorAlertWithMessage("You already have a workout with that name.  Pick another one.")
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "buildWorkout"{
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
