//
//  RuleViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/07/17.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import FontAwesomeKit

class RuleViewController: UIViewController {
    
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ruleLabel.attributedText = FAKFontAwesome.fileTextIcon(withSize: 18).attributedString()
        self.privacyPolicyLabel.attributedText = FAKFontAwesome.fileTextIcon(withSize: 18).attributedString()
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
