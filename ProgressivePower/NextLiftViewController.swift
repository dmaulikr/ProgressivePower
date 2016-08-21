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
    
    @IBAction func changeTouched(sender: AnyObject) {
        let randomColor = UIColor(randomColorInArray: Constants.themeColorPalette)
        
        self.navigationController?.navigationBar.barTintColor = randomColor
        
        self.tabBarController?.tabBar.barTintColor = randomColor
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        
    }
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        self.tableView.tableFooterView = UIView()
        
        self.tableView.registerNib(UINib(nibName: NextLiftTableCellIdentifier, bundle: nil), forCellReuseIdentifier: NextLiftTableCellIdentifier)
    }
    
    func workoutHistory() -> Results<WorkoutHistoryLog>{
        let realm = try! Realm()
        return realm.objects(WorkoutHistoryLog.self)
    }
    func currentSplit() -> Results<CurrentState>{
        let realm = try! Realm()
        return realm.objects(CurrentState.self)
    }
    //MARK: -Empty Data Set Delegate

    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Welcome"
        let attributes = [
            NSFontAttributeName : UIFont.boldSystemFontOfSize(18.0),
            NSForegroundColorAttributeName: UIColor.flatGrayColorDark()
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "This is where you will come to get Stronger Every Day. Make a split in the Plan tab!"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .ByWordWrapping
        paragraph.alignment = .Center
        
        let attributes = [
            NSFontAttributeName : UIFont.systemFontOfSize(14.0),
            NSForegroundColorAttributeName: UIColor.flatGrayColor(),
            NSParagraphStyleAttributeName: paragraph
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    //MARK: -Table View Delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NextLiftTableCellIdentifier, forIndexPath: indexPath) as! NextLiftTableCell
        
        return cell
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return currentSplit().count
        } else{
            return workoutHistory().count
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
