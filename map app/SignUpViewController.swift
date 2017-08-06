//
//  SignUpViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/07/10.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import NCMB
import FontAwesomeKit


// TextFieldプロトコルを追加
class SignUpViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var usernameIconLabel: UILabel!
    @IBOutlet weak var mailAdressIconLabel: UILabel!
    @IBOutlet weak var passwordIconLabel: UILabel!
    @IBOutlet weak var confirmIconLabel: UILabel!
    @IBOutlet weak var checkIconLabel: UILabel!
    @IBOutlet weak var alertLbel: UILabel!
    @IBOutlet weak var checkAlertLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // キーボードを閉じる(完了ボタンの検知の)ためにDelegateを設定
        usernameTextField.delegate = self
        mailAddressTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
        usernameTextField.placeholder = "username"
        mailAddressTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        confirmTextField.placeholder = "Password（Confirmation）"
        
        self.usernameIconLabel.attributedText = FAKFontAwesome.userOIcon(withSize: 15).attributedString()
        self.mailAdressIconLabel.attributedText = FAKFontAwesome.envelopeIcon(withSize: 15).attributedString()
        self.passwordIconLabel.attributedText = FAKFontAwesome.keyIcon(withSize: 15).attributedString()
        self.confirmIconLabel.attributedText = FAKFontAwesome.exclamationIcon(withSize: 15).attributedString()
        
        checkIconLabel.layer.borderWidth = 0.5
        checkIconLabel.layer.borderColor = UIColor.black.cgColor
        
        scrollView.delegate = self
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(mailAddressTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(confirmTextField)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(SignUpViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(SignUpViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        
        let usernameLimit = usernameTextField.frame.origin.y + usernameTextField.frame.height + 8.0
        let mailAdressLimit = mailAddressTextField.frame.origin.y + mailAddressTextField.frame.height + 8.0
        let passwordLimit = passwordTextField.frame.origin.y + passwordTextField.frame.height + 8.0
        let confirmLimit = confirmTextField.frame.origin.y + confirmTextField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        
        
        
        if usernameLimit >= kbdLimit {
            scrollView.contentOffset.y = usernameLimit - kbdLimit
        }
        if mailAdressLimit >= kbdLimit{
            scrollView.contentOffset.y = mailAdressLimit - kbdLimit
        }
        if passwordLimit >= kbdLimit{
            scrollView.contentOffset.y = passwordLimit - kbdLimit
        }
        if confirmLimit >= kbdLimit{
            scrollView.contentOffset.y = confirmLimit - kbdLimit
        }
        
        
        
    }
    
    func handleKeyboardWillHideNotification(_ notification: Notification) {
        scrollView.contentOffset.y = 0
    }
    
    
    
    // キーボードのReturnキーが押されたときを検知し、キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func checkButtonPush(){
        self.checkIconLabel.attributedText = FAKFontAwesome.checkIcon(withSize: 17).attributedString()
        let ud = UserDefaults.standard
        ud.set(true, forKey: "isCheck")
        ud.synchronize()
    }
    
    
    
    @IBAction func registerUser(_ sender: Any) {
        
        
        // ちゃんと書き込まれているかチェックし、文字数が0なら反応しないようにする
        if usernameTextField.text?.characters.count == 0 {
            return
        }
        
        if mailAddressTextField.text?.characters.count == 0 {
            return
        }
        
        if passwordTextField.text?.characters.count == 0 {
            return
        }
        
        if passwordTextField.text != confirmTextField.text {
            return
        }
        
        // ユーザー情報をNCMBのユーザー情報を保存するクラスに保存
        // CRUDの「C」(Create)
        let users = NCMBUser()
        users.userName = usernameTextField.text
        users.mailAddress = mailAddressTextField.text
        users.password = passwordTextField.text
        
        NCMBUser.requestAuthenticationMail(mailAddressTextField.text, error: nil)
        users.signUpInBackground { (error) in
            if error != nil {
                // エラーが起きた場合
                print(error!.localizedDescription)
            } else {
                
                
                // UserDefaultsにログイン済みと記録
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isSignIn")
                ud.synchronize()
                
                let userDefaults = UserDefaults.standard
                let isCheck = userDefaults.bool(forKey: "isCheck")
                
                if isCheck == false{
                    self.alertLbel.backgroundColor = UIColor(red: 255, green: 189, blue: 181, alpha: 1.0)
                    self.checkAlertLabel.text = "※利用規約に同意してください"
                }else{
                    self.performSegue(withIdentifier: "toStartView2", sender: nil)
                }
            }
        }
    }
    
    
}
