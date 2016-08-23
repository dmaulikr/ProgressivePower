//
//  AppDelegate.swift
//  ProgressivePower
//
//  Created by Michael Lee on 7/28/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupApplication()
        // Override point for customization after application launch.
        return true
    }
    func setupApplication(){
        var tempArray: Array<Exercise> = []
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)){
            if let path = NSBundle.mainBundle().pathForResource("exercises", ofType: "json"){
                do{
                    let jsonData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                    do {
                        let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers ) as! NSArray
                        var mapResult = [:]
                        if let mapPath = NSBundle.mainBundle().pathForResource("exercisePictureMap", ofType: "json"){
                            do{
                                let mapData = try NSData(contentsOfFile: mapPath, options: .DataReadingMappedIfSafe)
                                mapResult = try NSJSONSerialization.JSONObjectWithData(mapData, options: .MutableContainers ) as! NSDictionary
                            } catch{
                            }
                        }
                        for dict in jsonResult as! [NSDictionary]{
                            let exerciseName: String = dict.allKeys[0] as! String//Get key value to open object data
                            
                            let details = dict.valueForKey(exerciseName) //Get details
                            
                            let exerciseDetails = Mapper<ExerciseDetails>().map(details)
                            
                            let exercise = Exercise()
                            
                            let exerciseImageName = mapResult.objectForKey(exerciseName) as? String
                            if let exerciseImageName = exerciseImageName{
                                if exerciseImageName != ""{
                                    exercise.imageName =  "\(exerciseImageName)_1.png"
                                }
                            }
                            exercise.name = exerciseName
                            if let exerciseDetails = exerciseDetails{
                                exercise.details = exerciseDetails
                            }
                            tempArray.append(exercise)
                        }
                        ExerciseData.allExercises = tempArray
                    } catch{
                    }
                } catch{
                }
            }
            
        }
        
        let realm = try! Realm()
        let container = realm.objects(CurrentState.self)
        if container.count == 0{
            do{
                try realm.write {
                    realm.create(CurrentState.self, value: ["id": 1, "themeColorIndex": 0], update: true)
                }
            } catch{
            }
        }
        let color = Algorithm.currentThemeColor()
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let tabBarItemAppearanceNormal = [NSForegroundColorAttributeName: UIColor.flatGrayColorDark()]
        let tabBarItemAppearanceSelected = [NSForegroundColorAttributeName: color]
        
        UITabBarItem.appearance().setTitleTextAttributes(tabBarItemAppearanceNormal, forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes(tabBarItemAppearanceSelected, forState: .Selected)
        
        UINavigationBar.appearance().barTintColor = color
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = titleDict as? [String : AnyObject]
        
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

