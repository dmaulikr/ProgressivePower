//
//  AppDelegate.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import ObjectMapper
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        var tempArray: Array<Exercise> = []
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            if let path = NSBundle.mainBundle().pathForResource("exercises", ofType: "json"){
                do{
                    let jsonData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                    do {
                        let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers ) as! NSArray
                        for dict in jsonResult as! [NSDictionary]{
                            let exerciseName: String = dict.allKeys[0] as! String//Get key value to open object data
                            let details = dict.valueForKey(exerciseName) //Get details
                            
                            let exerciseDetails = Mapper<ExerciseDetails>().map(details)
                            
                            let exercise = Exercise()
                            exercise.name = exerciseName
                            if let exerciseDetails = exerciseDetails{
                                exercise.details = exerciseDetails
                            }
                            tempArray.append(exercise)
                        }
                        ExerciseData.allExercises = tempArray
                    } catch let error as NSError{
                        print(error)
                    }
                } catch let error as NSError{
                    print(error)
                }
            }

        }
        let randomColor = UIColor(randomColorInArray: Constants.themeColorPalette)
    
        UINavigationBar.appearance().barTintColor = randomColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

        UITabBar.appearance().barTintColor = randomColor
        UITabBar.appearance().tintColor = UIColor.whiteColor()

        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

