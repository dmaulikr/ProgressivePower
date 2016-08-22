//
//  PlateCalculator.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/29/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift

struct Algorithm{
    
    static func plateArrayForWeight(weight :Int) -> Array<Int> {
        
        let adjustedWeight = weight - 45
        
        let p45 = adjustedWeight / 90
        var remainder = weight % 90
        
        let p25 = remainder / 50
        remainder = remainder % 50
        
        let p10 = remainder / 20
        remainder = remainder % 20
        
        let p5 = remainder / 10
        remainder = remainder % 10
        
        let lp25 = remainder / 5
        remainder = remainder % 5
        
        return [p45, p25, p10, p5, lp25]

    }
    static func presentErrorAlertWithMessage(message :String, sender : UIViewController){
        let controller = UIAlertController(title: "Error", message:message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        controller.addAction(okAction)
        
        sender.presentViewController(controller, animated: true, completion: nil)
    }
    
    static func filteredArrayForArray(arrayToFilter: [String], filterTerm term: String) -> [String] {
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
    
    static func imageNameForExerciseName(name: String) -> String{
        if let exercises = ExerciseData.allExercises{
            for exc in exercises{
                if exc.name == name{
                    return exc.imageName
                }
            }
        }
        return ""
    }
    
    
}