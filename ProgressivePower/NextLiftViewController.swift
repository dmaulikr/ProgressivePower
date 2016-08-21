//
//  NextLiftViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import RealmSwift


class NextLiftViewController: UITableViewController {
    
    let NextLiftTableCellIdentifier = "NextLiftTableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: NextLiftTableCellIdentifier, bundle: nil), forCellReuseIdentifier: NextLiftTableCellIdentifier)
    }
    
    func workoutHistory() -> Results<WorkoutHistoryLog>{
        let realm = try! Realm()
        return realm.objects(WorkoutHistoryLog.self)
    }
    
    
    //MARK: -Table View Delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NextLiftTableCellIdentifier, forIndexPath: indexPath) as! NextLiftTableCell
        
        
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return ["Current Lift", "Next Lifts"]
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 1
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
