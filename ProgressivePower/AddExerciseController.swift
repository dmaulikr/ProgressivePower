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

    var workout: Workout?
    
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
        setupTextField()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
        let alertController = Algorithm.errorAlertWithMessage("One or more fields were invalid.  Please change them, and try again.")
        self.presentViewController(alertController, animated: true, completion: nil)
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
            return
        }
        
        if let weight = weightField.text{
            let weightValue = Double(weight)
            if let weight = weightValue{
                exercise.weight = weight
            }
            else{
                error()
                return
            }
        }
        switch progressionControl.selectedSegmentIndex {
        case 0:
            exercise.progression = 2.5
        case 2:
            exercise.progression = 7.5
        case 3:
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
                    return
                }

            }
            if let reps = repsField.text{
                let repValue = Int(reps)
                if let reps = repValue{
                    exercise.reps = reps
                }
                else{
                    error()
                    return
                }
            }
        default:
            exercise.sets = 5
            exercise.reps = 5
        }
        
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(exercise)
        workout?.exercises.append(exercise)
        try! realm.commitWrite()
        //Pop back to build controller
        self.navigationController?.popViewControllerAnimated(true)
    }
    func setupTextField(){
        var strings: [String] = []
        if let exerciseArray = ExerciseData.allExercises{
            for exercise in exerciseArray{
                strings.append(exercise.name)
            }
        }
        
        exerciseField.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        exerciseField.autoCompleteTextFont = UIFont.systemFontOfSize(14)
        exerciseField.autoCompleteCellHeight = 35.0
        exerciseField.maximumAutoCompleteCount = 10
        exerciseField.autocorrectionType = .No
        exerciseField.hidesWhenSelected = true
        exerciseField.hidesWhenEmpty = true
        exerciseField.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
        attributes[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        exerciseField.autoCompleteAttributes = attributes
        
        exerciseField.onTextChange = {text in
        self.exerciseField.autoCompleteStrings = self.filteredArrayForArray(strings, filterTerm: text)
        }
        
        exerciseField.onSelect = {text, indexpath in
        print(text)
        print(indexpath.row)
        }
    }
    
    func filteredArrayForArray(arrayToFilter: [String], filterTerm term: String) -> [String] {
        if (term == "") {
            return arrayToFilter
        }
        var filteredArray: [String] = []
        for entry: String in arrayToFilter {
            if entry.lowercaseString.containsString(term.lowercaseString) {
                filteredArray.append(entry)
            }
        }
        return filteredArray
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
