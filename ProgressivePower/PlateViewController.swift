//
//  PlateViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/29/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit

class PlateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let plates = PlateGenerator(frame: CGRectMake(0,0,self.view.frame.size.width, 375))
        plates.center.y = self.view.center.y;
        self.view.addSubview(plates)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
