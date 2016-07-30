//
//  PlanViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import Spring

class PlanViewController: UIViewController {

    @IBOutlet weak var autocompleteTextfield: AutoCompleteTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureTextField(){
        var strings: [String] = []
        if let exerciseArray = ExerciseData.allExercises{
            for exercise in exerciseArray{
                strings.append(exercise.name)
            }
        }
        autocompleteTextfield.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        autocompleteTextfield.autoCompleteTextFont = UIFont.systemFontOfSize(14)
        autocompleteTextfield.autoCompleteCellHeight = 35.0
        autocompleteTextfield.maximumAutoCompleteCount = 10
        autocompleteTextfield.autocorrectionType = .No
        autocompleteTextfield.hidesWhenSelected = true
        autocompleteTextfield.hidesWhenEmpty = true
        autocompleteTextfield.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
        attributes[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        autocompleteTextfield.autoCompleteAttributes = attributes
        
        autocompleteTextfield.onTextChange = {text in
            self.autocompleteTextfield.autoCompleteStrings = self.filteredArrayForArray(strings, filterTerm: text)
        }
        
        autocompleteTextfield.onSelect = {text, indexpath in
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

