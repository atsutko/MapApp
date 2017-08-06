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
import TwitterKit
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit

class SignInViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailAddressIconLabel: UILabel!
    @IBOutlet weak var passwordIconLabel: UILabel!
    @IBOutlet weak var facebookIconLabel: UILabel!
    @IBOutlet weak var twitterIconLabel: UILabel!
    @IBOutlet weak var userPlusIconLabel: UILabel!
    @IBOutlet weak var twitterLoginButton: TWTRLogInButton!

    //  @IBOutlet weak var twitterLoginButton: TWTRLogInButton!
    
    var emailAdress: String!
    var password: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailAddressTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        mailAddressIconLabel.attributedText = FAKFontAwesome.envelopeIcon(withSize: 17).attributedString()
        passwordIconLabel.attributedText = FAKFontAwesome.keyIcon(withSize: 17).attributedString()
        facebookIconLabel.attributedText = FAKFontAwesome.facebookIcon(withSize: 17).attributedString()
        twitterIconLabel.attributedText = FAKFontAwesome.twitterIcon(withSize: 17).attributedString()
        self.userPlusIconLabel.attributedText = FAKFontAwesome.userPlusIcon(withSize: 17).attributedString()
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
    
    
    
   @IBAction func twitterLoginButtonPressed(sender: UIButton) {
    Twitter.sharedInstance().logIn(completion: { (session, error) in
        if session != nil {
            print("signed in as \(session!.userName), \(session!.userID)");
            
            let client = TWTRAPIClient(userID: session!.userID)
            client.requestEmail { email, error in
                if email != nil {
                    print("signed in as \(session!.userName)");
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let viewController = storyboard.instantiateInitialViewController()
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window!?.rootViewController = viewController
                    appDelegate?.window!?.makeKeyAndVisible()
                } else {
                    print("error: \(error!.localizedDescription)");
                }
            }
        } else {
            print("error: \(error!.localizedDescription)");
        }
    })
    
    

    }
 

    
     @IBAction func facebookLoginButton(sender: AnyObject) {
     NCMBFacebookUtils.logInWithReadPermission(["email"]) {(user, error) -> Void in
     if (error != nil){
     if (error.code == NCMBErrorFacebookLoginCancelled){
     // Facebookのログインがキャンセルされた場合
     
     }else{
     // その他のエラーが発生した場合
     
     }
     }else{
     // 会員登録後の処理
     
     }
     }
     }
    
    
}
