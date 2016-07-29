//
//  WorkoutTableViewCell.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import SnapKit

class WorkoutCell: UITableViewCell {
    var exercises: Array<UserExercise>?
    var nameLabel :UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let test = UserExercise()
        test.name = "Barbell Back Squat"
        let test1 = UserExercise()
        test1.name = "Barbell Front Squat"
        let test2 = UserExercise()
        test2.name = "Barbell Upright Row"
        exercises = [test, test1, test2]
        
        if let exercises = exercises{
            let lastIndex = exercises.count - 1
            
            for (index, exercise) in exercises.enumerate() {
                let nameLabel = UILabel()
                print(index)
                print(lastIndex)
                nameLabel.text = exercise.name
                nameLabel.font = UIFont.systemFontOfSize(15)
                nameLabel.sizeToFit()
                
                self.addSubview(nameLabel)
                
            
            }
        }

    }
    
    func injected(){
        
        self.configureCell()
    }
    

}
