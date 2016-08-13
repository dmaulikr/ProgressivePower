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
