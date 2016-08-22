//
//  WorkoutCollectionCell.swift
//  ProgressivePower
//
//  Created by Michael Lee on 8/9/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import SnapKit

class WorkoutCollectionCell: UICollectionViewCell {
    
    let labelMargin = 20
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
    func configureCellWithWorkout(workout : Workout){
        print("One:\(self.contentView.center.x)")
        print("Two:\(nameLabel.center.x)")
        
        nameLabel.text = workout.name
    
        let size = Int(self.frame.size.height)
        let exercises = workout.exercises
        let numberOfPossibleLabels = size/labelMargin
        let numberOfLabels = min(exercises.count, numberOfPossibleLabels)
        
        
        for x in 0..<numberOfLabels{
            let label = UILabel()
            let trueMargin = CGFloat(x) * CGFloat(labelMargin)
            
            label.text = exercises[x].name
            label.font = UIFont.systemFontOfSize(12)
            label.textColor = UIColor.flatGrayColorDark()
            label.sizeToFit()
            self.contentView.addSubview(label)
            
            let nameLabelBottom = self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height
                
            label.snp_makeConstraints(closure: { make in
                make.leading.equalTo(self.contentView).offset(10)
                make.trailing.lessThanOrEqualTo(self.contentView).offset(-10)
                make.top.equalTo(nameLabelBottom + trueMargin + 5)
            })
            
        }
        
    }
}
