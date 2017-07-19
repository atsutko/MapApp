//
//  SignInViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/07/10.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import NCMB
import FontAwesomeKit

class SignInViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailAddressIconLabel: UILabel!
    @IBOutlet weak var passwordIconLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    
    
    var emailAdress: String!
    var password: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailAddressTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        mailAddressIconLabel.attributedText = FAKFontAwesome.envelopeIcon(withSize: 15).attributedString()
        passwordIconLabel.attributedText = FAKFontAwesome.keyIcon(withSize: 15).attributedString()
        mailAddressTextField.delegate = self
        passwordTextField.delegate = self
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailAdress = mailAddressTextField.text
        password = passwordTextField.text
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signIn() {
        
        // メールアドレス、パスワードに何も入力されていなかったら反応しないようにする
        guard let address = mailAddressTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        // ログイン
        NCMBUser.logInWithMailAddress(inBackground: address, password: password) { (user, error) in
            if error != nil {
                // エラーが起きた場合は出力
                print(error!.localizedDescription)
            } else {
              
                
                // UserDefaultsのログイン情報をログイン済に変更
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isSignIn")
                ud.synchronize()
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewController = storyboard.instantiateInitialViewController()
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window!?.rootViewController = viewController
                appDelegate?.window!?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func SwitchPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func checkAction(){
        self.checkLabel.attributedText = FAKFontAwesome.checkIcon(withSize: 18).attributedString()
    }
    
    func touchBtnClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
