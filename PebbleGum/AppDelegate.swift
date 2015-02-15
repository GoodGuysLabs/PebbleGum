//
//  AppDelegate.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 01/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import UIKit
import CoreData
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let mainController = NavigationController(nibName: nil, bundle: nil)
        mainController.navController?.pushViewController(MainViewController(nibName: nil, bundle: nil), animated: false)
        self.window!.rootViewController = mainController.navController
        self.window!.makeKeyAndVisible()
        
        let categories = Category.allObjects()
        if categories.count == 0 {
            
            let defaultCategories: Dictionary<String, String> = [
                "Password":     "fa-key",
                "Secret":       "fa-user-secret",
                "Code":         "fa-code",
                "Apple":        "fa-apple",
                "Behance":      "fa-behance-square",
                "Bitbucket":    "fa-bitbucket-square",
                "Codepen":      "fa-codepen",
                "Database":     "fa-database",
                "DeviantArt":   "fa-devianart",
                "Digg":         "fa-digg",
                "Dropbox":      "fa-dropbox",
                "Email":        "fa-envelope-square",
                "Facebook":     "fa-facebook-official",
                "Flickr":       "fa-flickr",
                "Foursquare":   "fa-foursquare",
                "Github":       "fa-github-square",
                "Google":       "fa-google",
                "Google+":      "fa-google-plus",
                "Instagram":    "fa-instagram",
                "LastFM":       "fa-lastfm",
                "LinkedIn":     "fa-linkedin",
                "Linux":        "fa-linux",
                "Live":         "fa-windows",
                "MaxCDN":       "fa-maxcdn",
                "Medium":       "fa-medium",
                "Paypal":       "fa-paypal",
                "Pinterest":    "fa-pinterest-p",
                "Reddit":       "fa-reddit",
                "Skype":        "fa-skype",
                "Slideshare":   "fa-slideshare",
                "Soundcloud":   "fa-soundcloud",
                "Spotify":      "fa-spotify",
                "Stack Overflow":"fa-stack-overflow",
                "Steam":        "fa-steam",
                "Twitch":       "fa-twitch",
                "Twitter":      "fa-twitter",
                "Vimeo":        "fa-vimeo",
                "Vine":         "fa-vine",
                "VK":           "fa-vk",
                "WhatsApp":     "fa-whatsapp",
                "Wordpress":    "fa-wordpress",
                "Yahoo":        "fa-yahoo",
                "Youtube":      "fa-youtube"
            ]
            
            let realm = RLMRealm.defaultRealm()
            
            for (name, icon) in defaultCategories {
                realm.beginWriteTransaction()
                let category: Category = Category()
                category.categoryName = name
                category.categoryIcon = icon
                realm.addOrUpdateObject(category)
                realm.commitWriteTransaction()
            }
            
        }
        
        println(Category.allObjects())
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        println("applicationWillResignActive")
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        println("applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        println("applicationWillEnterForeground")
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //var afterConnectViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        println("applicationDidBecomeActive")
        //self.viewController?.navigationController?.pushViewController(afterConnectViewController, animated: true)
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        println("applicationWillTerminate")
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "fr.GoodGuys.PebbleGum" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("PebbleGum", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("PebbleGum.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    
}

