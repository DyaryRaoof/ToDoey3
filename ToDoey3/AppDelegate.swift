//
//  AppDelegate.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/15/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       
        
      
        do{
            let realm = try Realm()
           
        }catch{
            print ("Error! couldn't intialize Realm \(error)")
        }
        
        
        return true
    }

}
