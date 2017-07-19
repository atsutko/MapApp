//
//  TutorialIconViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/06/21.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

class TutorialIconViewController: UIViewController {
    @IBOutlet weak var WiFiTutorialTextView: UITextView!
    @IBOutlet weak var ToiletteTutorialTextView: UITextView!
    @IBOutlet weak var ATMTutorialTextView: UITextView!
    @IBOutlet weak var BicycleTutorialTextView: UITextView!
    @IBOutlet weak var ConsentTutorialTextView: UITextView!
    @IBOutlet weak var OpenTutorialTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WiFiTutorialTextView.text = "Wi-Fi SPOT。Wi-Fiが使えるスポットを表します。"
        ToiletteTutorialTextView.text = "トイレSPOT。コンビニや公共のトイレなど、トイレの使える場所を表します。"
        ATMTutorialTextView.text = "ATM SPOT。ATMの利用できる場所を表します。場所名を書くところに銀行の種類名を書くと親切です。"
        BicycleTutorialTextView.text = "駐輪場SPOT。駐輪場の場所を表します。"
        ConsentTutorialTextView.text = "コンセントSPOT。コンセントの利用できる場所を表します。"
        OpenTutorialTextView.text = "24時間営業SPOT。24時間営業のお店の場所を表します。場所名のところにお店の種類を書くと親切です。"
        
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
