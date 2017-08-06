//
//  AppDelegate.swift
//  map app
//
//  Created by 高尾敦 on 2017/04/14.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

// NCMBフレームワークの読み込み
import NCMB

import FacebookCore
import FacebookLogin

import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
            SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Amenity.removeAll()
        NCMB.setApplicationKey("91f1ec8da2860b13ce557b8fe74c16e225fda5b40568c22a19ac347fd306ec97", clientKey: "78a84241ed998939ddd1619cd7483a5591c2a645bf0087671570882b23e6bdf0")
        Twitter.sharedInstance().start(withConsumerKey:"b0ELmrEIzcgTXWDt9ridhnpBH", consumerSecret:"QyLLK9Jwmocb0IOTy2nasfV5tiQJaESihWYurxBqJZJaEO9eIp")

        
      let ud = UserDefaults.standard
        let isLogin = ud.bool(forKey: "isSignIn")
        
        if isLogin == false {
            // ログイン済でなかった場合、ログイン用のStoryboardを初期画面として起動
            let rootViewController: SignInViewController = UIStoryboard(name: "SignIn", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            let navigation = UINavigationController(rootViewController: rootViewController)
            self.window?.rootViewController = navigation
        }else{
            StoryboardHelper.adjust(to: window)

        }

        
        let blackColor = UIColor(red: 5.0/255.0, green: 5.0/255.0, blue: 5.0/255.0, alpha:1)
        let whiteColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        let blueColor = UIColor(red: 49.0/255.0, green: 105.0/255.0, blue: 245.0/255.0, alpha: 1)
        let greenColor = UIColor(red: 8.0/255.0, green: 150.0/255.0, blue: 9.0/255.0, alpha: 1)
        
        // ① ナビゲーションバーの背景色
        UINavigationBar.appearance().barTintColor = blueColor
        
        // ② ナビゲーションバーのタイトルの色
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: whiteColor]
        
        // ③ ナビゲーションバー上のアイテムの色
        UINavigationBar.appearance().tintColor = whiteColor
        
        //self.navigationController?.navigationBar.titleTextAttributes
         //   = [NSFontAttributeName: UIFont(name: "CFBillabong-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Billabong", size: 25)!]
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        //return SDKApplicationDelegate.shared.application(app, open: url, options: options)
        return Twitter.sharedInstance().application(app, open: url, options: options)
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


}

