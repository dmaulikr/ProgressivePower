//
//  NextLiftViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class NextLiftViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    let NextLiftTableCellHeight = 120 as CGFloat
    let NextLiftTableCellIdentifier = "NextLiftTableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        self.title = "Next Lift"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        self.tableView.tableFooterView = UIView()
        
        self.tableView.registerNib(UINib(nibName: NextLiftTableCellIdentifier, bundle: nil), forCellReuseIdentifier: NextLiftTableCellIdentifier)
    }
    
    //MARK: -Empty Data Set Delegate

    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Welcome"
        let attributes = [
            NSFontAttributeName : UIFont.boldSystemFontOfSize(18.0),
            NSForegroundColorAttributeName: UIColor.flatBlackColor()
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "This is where you will get Stronger Every Day. Make a split in the Plan tab!"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .ByWordWrapping
        paragraph.alignment = .Center
        
        let attributes = [
            NSFontAttributeName : UIFont.systemFontOfSize(14.0),
            NSForegroundColorAttributeName: UIColor.flatGrayColorDark(),
            NSParagraphStyleAttributeName: paragraph
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func workoutForRepeatingCycle(index : Int) -> Workout{
        let workouts = DBAccessManager.objectsForType(Workout.self)
        let trueIndex = index % workouts.count
        
        return workouts[trueIndex]
    }
    
    //MARK: -Table View Delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NextLiftTableCellIdentifier, forIndexPath: indexPath) as! NextLiftTableCell
        cell.configureCellForWorkout(workoutForRepeatingCycle(indexPath.row))

        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NextLiftTableCellHeight
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Your Next Lift"
        } else{
            return "Future Lifts"
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DBAccessManager.objectsForType(Workout.self).count > 0{
            return section == 0 ? 1 : 5
        } else{
            return 0
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
