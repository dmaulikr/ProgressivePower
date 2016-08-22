//
//  Exercise.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import Foundation
import ObjectMapper

class Exercise: NSObject {
    //Don't map this object because need to get name from key
    dynamic var name = ""
    dynamic var imageName = ""
    dynamic var details: ExerciseDetails?
}
class ExerciseDetails: NSObject, Mappable {
    var primaryMuscle = ""
    var otherGroups  = ""
    var forceDirection = ""
    var equipment = ""
    var type = ""
    var mechanicsType = ""
   
    required convenience init?(_ map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        primaryMuscle <- map["Main Muscle Worked"]
        otherGroups <- map["Other Muscles"]
        forceDirection <- map["Force"]
        equipment <- map["Equipment"]
        type <- map["Type"]
        mechanicsType <- map["Mechanics Type"]
    }
}

