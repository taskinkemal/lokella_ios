//
//  AppDelegate.swift
//  lokella
//
//  Created by Kemal Taskin on 09.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        if DataStore.GetCustomer() == nil{
            let loginScreen = storyBoard.instantiateViewController(withIdentifier: "CustomerLoginController")
            self.window?.rootViewController = loginScreen

        }else{
            let mainScreen = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController")
            self.window?.rootViewController = mainScreen
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Determine who sent the URL.
        let sendingAppID = options[.sourceApplication]
        print("source application = \(sendingAppID ?? "Unknown")")
        
        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let path = components.path,
            let params = components.queryItems else {
                print("Invalid URL or path missing")
                return false
        }
        
        if let parameter = params.first(where: { $0.name == "code" })?.value {
            print("path = \(path)")
            print("parameter = \(parameter)")
            
            if (parameter == UIDevice.current.identifierForVendor!.uuidString) {
                
                DataStore.SetIsCustomerVerified(isVerified: true);
            }
            
            return true
        } else {
            print("parameter is missing")
            return false
        }
    }
}

