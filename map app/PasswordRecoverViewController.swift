//
//  PasswordRecoverViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/07/10.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

class PasswordRecoverViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "forgot password"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func recoberBtn(_ sender: Any) {
        let userEmail = userEmailTextField.text
        
    }
    
    
    
    
}
