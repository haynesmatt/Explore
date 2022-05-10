//
//  AppDelegate.swift
//  insteadOfLab6
//
//  Created by Robert Reyes-Enamorado on 3/9/22.
//

import UIKit
import Parse
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let parseConfig = ParseClientConfiguration {
                    $0.applicationId = "0YcSO82aJ4ZM7EQzAwx8pi902Q1sqf0OBPS0kzwO" // <- UPDATE
                    $0.clientKey = "dx5Tf2h5yzd83Dufq4JgZc9T12zC8v1PAE98fJoS" // <- UPDATE
                    $0.server = "https://parseapi.back4app.com"
            }
            Parse.initialize(with: parseConfig)
        
        
        // Below code will fix Navigation bar issue fixed for iOS 15.0
        if #available(iOS 15, *) {
                        let navigationBarAppearance = UINavigationBarAppearance()
                        navigationBarAppearance.configureWithOpaqueBackground()
                        navigationBarAppearance.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor : UIColor.white
                        ]
                        navigationBarAppearance.backgroundColor =  UIColor(red: 37/255.0, green: 90/255.0, blue: 181/255.0, alpha: 1)
                        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                    
                   // let tabBarApperance = UITabBarAppearance()
                   // tabBarApperance.configureWithOpaqueBackground()
                   // tabBarApperance.backgroundColor =  UIColor(red: 37/255.0, green: 90/255.0, blue: 181/255.0, alpha: 1)
           // UITabBar.appearance().unselectedItemTintColor = tabBarApperance.selectionIndicatorTintColor

                   // UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
                  //  UITabBar.appearance().standardAppearance = tabBarApperance
           // UITabBar.appearance().unselectedItemTintColor = UIColor.white
                }
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

