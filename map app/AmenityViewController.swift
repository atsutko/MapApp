//
//  LoginViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/04/14.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import FontAwesomeKit
import NCMB

class AmenityViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate {

    var placeTitle: String!
    var kindPlace: String!
    

    var image: UIImage! = nil
    
    @IBOutlet weak var placeTitlelabel: UILabel!
    @IBOutlet weak var reactionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var cameraIconLabel: UILabel!
    @IBOutlet weak var albumIconLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailTextField.delegate = self
        
            detailTextView.text = ""
     
        self.cameraIconLabel.attributedText = FAKFontAwesome.cameraIcon(withSize: 25).attributedString()
        self.albumIconLabel.attributedText = FAKFontAwesome.bookIcon(withSize: 25).attributedString()
     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.placeTitlelabel.text = placeTitle
        self.reactionLabel.text = kindPlace
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//detailTextFieldについて
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideDetailTextField()
        detailTextView.text = detailTextField.text!
        textField.resignFirstResponder()
        return true
    }
    
    // Private
    private func hideDetailTextField() {
        for view in self.view.subviews {
            if NSStringFromClass(type(of: view)) == "UITextField" {
                view.isHidden = true
            }
        }
    }
    
    
    @IBAction func cameraStart(_ sender: Any) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(cameraPicker, animated: true, completion: nil)
        }
            
        else{
            print("error")
            
        }}
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            
        }
        let image:UIImage! = imageView.image
        
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(AmenityViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            
        }
        else{
            print("image Failed !")
        }
        
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }
    
       // 書き込み完了結果の受け取り
    func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        print("1")
        
        if error != nil {
            print(error.code)
        }
        else{
            print("Save Succeeded")
        }
    }
    @IBAction func showAlbum(_ sender : AnyObject) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(cameraPicker, animated: true, completion: nil)
            
                   }
      

}
}
