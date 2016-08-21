//
//  NextLiftTableCell.swift
//  ProgressivePower
//
//  Created by Michael Lee on 8/20/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit

class NextLiftTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var exerciseOneNameLabel: UILabel!
    @IBOutlet weak var exerciseOneInfoLabel: UILabel!
    
    @IBOutlet weak var exerciseTwoNameLabel: UILabel!
    @IBOutlet weak var exerciseTwoInfoLabel: UILabel!

    @IBOutlet weak var exerciseThreeNameLabel: UILabel!
    @IBOutlet weak var exerciseThreeInfoLabel: UILabel!
    
    @IBOutlet weak var moreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCellForWorkout(workout: Workout){
        let exercises = workout.exercises
        let count = exercises.count
        
        if count == 0{
            exerciseOneNameLabel.text = "No exercises"
        }
        if count > 0{
            exerciseOneInfoLabel.hidden = false
            exerciseOneInfoLabel.text = infoTextForExercise(exercises[0])
            exerciseOneNameLabel.text = exercises[0].name
            if count > 1{
                exerciseTwoNameLabel.hidden = false
                exerciseTwoInfoLabel.hidden = false
                exerciseTwoNameLabel.text = exercises[1].name
                exerciseTwoInfoLabel.text = infoTextForExercise(exercises[1])
                if count > 2{
                    exerciseThreeNameLabel.hidden = false
                    exerciseThreeInfoLabel.hidden = false
                    exerciseThreeNameLabel.text = exercises[2].name
                    exerciseThreeInfoLabel.text = infoTextForExercise(exercises[2])
                    if count > 3{
                        moreLabel.hidden = false
                    }
                }
            }
        }
        nameLabel.text = workout.name
    }
    
    func infoTextForExercise(exercise: UserExercises) -> String{
        let reps = String(exercise.reps)
        let sets = String(exercise.sets)
        let weight = String(exercise.weight)
        return "\(sets)x\(reps) - \(weight)"
    }
    
    
    
}
