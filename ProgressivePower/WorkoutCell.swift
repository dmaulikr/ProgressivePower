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
        
        let test = UserExercise()
        test.name = "Barbell Back Squat"
        exercises = [test]
        
        if let exercises = exercises{
            for (index, exercise) in exercises.enumerate() {
                nameLabel = UILabel()
                
                nameLabel.text = exercise.name
                nameLabel.font = UIFont.systemFontOfSize(15)
                nameLabel.sizeToFit()
                
                self.addSubview(nameLabel)
                
                nameLabel.snp_makeConstraints(closure: { (make) in
                    make.centerX.equalTo(self).offset(-60)
                    make.top.equalTo(self).offset(20)
                    
                })
            }
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func injected(){
        nameLabel.font = UIFont.systemFontOfSize(17)
        
    }
    

}
