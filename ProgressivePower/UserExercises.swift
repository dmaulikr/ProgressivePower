//
//  UserExercises.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import Foundation
import RealmSwift

class UserExercise: Object{
    dynamic var name = ""
    dynamic var sets = 0
    dynamic var lowerRepRange = 0
    dynamic var upperRepRange = 0
    dynamic var currentRepRange = 0;
}
class Workout: Object{
    let exercises = List<UserExercise>()
}
class Split: Object {
    let workouts = List<Workout>()
}
