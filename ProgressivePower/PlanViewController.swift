//
//  PlanViewController.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import ChameleonFramework

class PlanViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Splits"
        let s = PlateGenerator(frame: self.view.frame)
        self.view.addSubview(s)
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

