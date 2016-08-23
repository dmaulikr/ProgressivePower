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
        setupNav()
        print(workout!)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNav(){
        self.title = "New Exercise"
    }
    
    @IBAction func schemeDidChange(sender: AnyObject) {
        let control = sender as! UISegmentedControl
        if control.selectedSegmentIndex == 2{
            changeSchemeFieldAlphaTo(false)
        }
        else {
            changeSchemeFieldAlphaTo(true)
        }
    
    }
    func changeSchemeFieldAlphaTo(value:Bool){
        setsLabel.hidden = value
        repsLabel.hidden = value
        setsField.hidden = value
        repsField.hidden = value
    }

    //Check whether exercise name exists in exercise data.
    @IBAction func createExercisePressed(sender: AnyObject){
        do{
            try createExercise()
            self.navigationController?.popViewControllerAnimated(true)
        } catch PPError.DBFail{
            Algorithm.presentErrorAlertWithMessage("Save failure.  Please try again.", sender: self)
        } catch PPError.NoValue{
            Algorithm.presentErrorAlertWithMessage("One or more fields were empty", sender: self)
        } catch PPError.InvalidValue{
            Algorithm.presentErrorAlertWithMessage("One or more fields had an invalid value.", sender: self)
        } catch{
            Algorithm.presentErrorAlertWithMessage("An unknown error occured", sender: self)
        }
    }
    
    func createExercise() throws{
        if schemeControl.selectedSegmentIndex == 2 && (self.setsField.text == nil || self.repsField.text == nil){
            throw PPError.NoValue
        }
        let exercise = UserExercises()
        guard let name = exerciseField.text else{
            throw PPError.NoValue
        }
        guard let weight = weightField.text else{
            throw PPError.NoValue
        }
        guard let exerciseWeight = Double(weight) else{
            throw PPError.InvalidValue
        }
        exercise.name = name
        exercise.weight = exerciseWeight
        
        if progressionControl.selectedSegmentIndex == 0{
            exercise.progression = 2.5
        } else{
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
            guard let sets = setsField.text else{
                throw PPError.NoValue
            }
            guard let exerciseSets = Int(sets) else{
                throw PPError.InvalidValue
            }
            exercise.sets = exerciseSets
            
            
            guard let reps = repsField.text else{
                throw PPError.NoValue
            }
            guard let exerciseReps = Int(reps) else{
                throw PPError.InvalidValue
            }
            exercise.reps = exerciseReps
            
        default:
            exercise.sets = 5
            exercise.reps = 5
        }
        
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(exercise)
        workout?.exercises.append(exercise)
        do{
            try realm.commitWrite()
        } catch {
            throw PPError.DBFail
        }
        //Pop back to build controller
        //self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setupTextField(){
        var strings: [String] = []
        if let exerciseArray = ExerciseData.allExercises{
            for exercise in exerciseArray{
                strings.append(exercise.name)
            }
        }
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
        attributes[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        
        exerciseField.autoCompleteTextColor = UIColor.flatGrayColorDark()
        exerciseField.autoCompleteTextFont = UIFont.systemFontOfSize(14)
        exerciseField.autoCompleteCellHeight = 50.0
        exerciseField.maximumAutoCompleteCount = 10
        exerciseField.autocorrectionType = .No
        exerciseField.hidesWhenSelected = true
        exerciseField.hidesWhenEmpty = true
        exerciseField.enableAttributedText = true
        exerciseField.autoCompleteAttributes = attributes
        exerciseField.onTextChange = {text in
            self.exerciseField.autoCompleteStrings = Algorithm.filteredArrayForArray(strings, filterTerm: text)
        }
        exerciseField.onSelect = {text, indexpath in
            print(text)
            print(indexpath.row)
        }
    }
}
