//
//  MapTabBarController.swift
//  map app
//
//  Created by AtsushiTakao on 2017/07/22.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

class MapTabBarController: UITabBarController {
    
    let whiteColor = UIColor(red: 253.0/255.0, green: 253.0/255.0, blue: 253.0/255.0, alpha: 1)
    let greenColor = UIColor(red: 8.0/255.0, green: 150.0/255.0, blue: 9.0/255.0, alpha: 1)
    let blueColor = UIColor(red: 49.0/255.0, green: 105.0/255.0, blue: 245.0/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // アイコンの色
        UITabBar.appearance().tintColor = whiteColor
        
        // 背景色
        UITabBar.appearance().barTintColor = blueColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
