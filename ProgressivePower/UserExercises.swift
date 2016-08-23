//
//  UserExercises.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import Foundation
import RealmSwift

class UserExercises: Object{
    dynamic var name = ""
    dynamic var weight = 0.0
    dynamic var sets = 0
    dynamic var reps = 0
    dynamic var progression = 0.0
}
class Workout: Object{
    dynamic var name = ""
    let exercises = List<UserExercises>()
}
class Split: Object {
    let workouts = List<Workout>()
}
//History databasing
class CurrentState : Object{
    dynamic var id = 0
    dynamic var currentSplit: Split?
    dynamic var splitIndex = 0
    dynamic var themeColorIndex = 0
    
    //Add a primary key to be able to update the state
    override static func primaryKey() -> String? {
        return "id"
    }
}
class ExerciseHistoryLog: Object{
    dynamic var name = ""
    dynamic var weight = 0.0
    dynamic var sets = 0
    dynamic var reps = 0
    dynamic var progression = 0.0
}
class WorkoutHistoryLog: Object{
    dynamic var name = ""
    dynamic var date = NSDate()
    let exerciseLogs = List<ExerciseHistoryLog>()
}
