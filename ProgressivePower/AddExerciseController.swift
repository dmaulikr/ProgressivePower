//
//  AddExerciseController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/30/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift

class AddExerciseController: UIViewController {

    @IBOutlet weak var exerciseField: AutoCompleteTextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var progressionControl: UISegmentedControl!
    @IBOutlet weak var schemeControl: UISegmentedControl!
    
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!

    @IBOutlet weak var setsField: UITextField!
    @IBOutlet weak var repsField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func schemeDidChange(sender: AnyObject) {
        let control = sender as! UISegmentedControl
        if control.selectedSegmentIndex == 2{
            changeSchemeFieldAlphaTo(true)
        }
        else {
            changeSchemeFieldAlphaTo(false)
        }
    
    }
    func changeSchemeFieldAlphaTo(value:Bool){
        setsLabel.hidden = value
        repsLabel.hidden = value
        setsField.hidden = value
        repsField.hidden = value
    }
    func error(){
        let controller = UIAlertController(title: "Error", message: "One or more of the fields were invalid", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        controller.addAction(okAction)
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    //Check whether exercise name exists in exercise data.
    @IBAction func createExercisePressed(sender: AnyObject) {
        if self.exerciseField.text == nil || self.weightField.text == nil || (schemeControl.selectedSegmentIndex == 2 && (self.setsField.text == nil || self.repsField.text == nil)){
        //Error message
            return;
        }
        
        let exercise = UserExercises()
        if let name = exerciseField.text{
            exercise.name = name
        }
        else{
            error()
        }
        
        if let weight = weightField.text{
            let weightValue = Double(weight)
            if let weight = weightValue{
                exercise.weight = weight
            }
            else{
                error()
            }
        }
        switch progressionControl.selectedSegmentIndex {
        case 0:
            exercise.progression = 2.5
        case 2:
            exercise.progression = 7.5
        case 4:
            exercise.progression = 10.0
        default:
            exercise.progression = 5.0
        }
        switch schemeControl.selectedSegmentIndex {
        case 0:
            exercise.sets = 5
            exercise.reps = 5
        case 1:
            exercise.sets = 3
            exercise.reps = 8
        case 2:
            if let sets = setsField.text{
                let setValue = Int(sets)
                if let sets = setValue{
                    exercise.sets = sets
                }
                else{
                    error()
                }

            }
            if let reps = repsField.text{
                let repValue = Int(reps)
                if let reps = repValue{
                    exercise.reps = reps
                }
                else{
                    error()
                }
            }
        default:
            exercise.sets = 5
            exercise.reps = 5
        }
        //Save to db
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(exercise)
        try! realm.commitWrite()
        //Pop back to build controller
        self.navigationController?.popViewControllerAnimated(true)
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
