//
//  TurorialMapViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/06/18.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

class TurorialMapViewController: UIViewController {

    @IBOutlet weak var tutorialMapTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      tutorialMapTextView.text = "発生させたい場所を\nロングタップしよう！\nリロードボタンでどんどん更新！！"
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
