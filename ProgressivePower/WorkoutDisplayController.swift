//
//  PlanViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import Spring
import RealmSwift

let WorkoutCellIdentifier = "WorkoutCollectionCell"
let CreateSegueIdentifier = "createWorkoutSegue"

let cellHeight = 150 as CGFloat
let margin = 10 as CGFloat

class WorkoutDisplayController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func allWorkouts() -> Results<Workout>{
        let realm = try! Realm()
        return realm.objects(Workout.self)
    }
    
    func setupCollectionView(){
        self.collectionView?.registerNib(UINib(nibName: WorkoutCellIdentifier, bundle: nil), forCellWithReuseIdentifier: WorkoutCellIdentifier);
    }
    
    // MARK: Collection view delegate
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Add a cell for add workout cell
        return allWorkouts().count + 1
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier(WorkoutCellIdentifier, forIndexPath: indexPath) as! WorkoutCollectionCell
        if indexPath.row == 0{
            cell.nameLabel.text = "Add workout";
        } else{
            cell.nameLabel.text = allWorkouts()[indexPath.row - 1].name;
        }
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            self.performSegueWithIdentifier(CreateSegueIdentifier, sender: self)
        } else{
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = self.view.frame.size.width;
        let height = cellHeight
        //Two cells on each row with 3 spaces in total
        let width = (screenWidth/2) - ((margin * 3)/2)
        return CGSizeMake(width, height)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(margin, margin, margin, margin)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return margin
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return margin
    }
    


}

