//
//  WorkoutBuildTableCell.swift
//  ProgressivePower
//
//  Created by Michael Lee on 8/20/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit

class WorkoutBuildTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var progressionLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var highlightView: UIView!
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    static func cellHeight() -> CGFloat{
        return 80.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithExercise(exercise: UserExercises){
        nameLabel.text = exercise.name
        weightLabel.text = "\(String(exercise.weight)) lbs"
        progressionLabel.text = "+\(String(exercise.progression)) lbs"
        setsLabel.text = String(exercise.sets)
        repsLabel.text = String(exercise.reps)
        
        var imageNameText = ""
        if let exercises = ExerciseData.allExercises{
            for exc in exercises{
                if exc.name == exercise.name{
                    imageNameText = exc.imageName
                    break
                }
            }
        }
        if imageNameText != ""{
            leadingConstraint.constant = WorkoutBuildTableCell.cellHeight() - 5
            exerciseImageView.hidden = false
            exerciseImageView.image = UIImage(named: imageNameText)
        }
        
    }
    
}
