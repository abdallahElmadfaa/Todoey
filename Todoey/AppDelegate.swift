//
//  AppDelegate.swift
//  Todoey
//
//  Created by Abdallah Elmadfa'a on 07/02/2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
          
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do {
            _ = try Realm()
             
        } catch {
            print("Error initialising mew realm , \(error)")
        }
      
        
        
        return true
    }


    

}

