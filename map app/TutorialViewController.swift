//
//  TutorialViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/06/17.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    
    @IBOutlet weak var tutorialMapButton: UIButton!
    @IBOutlet weak var tutorialIconButton: UIButton!
    @IBOutlet weak var tutorialDetailButton: UIButton!
    
    var startY: CGFloat = -10.0
    var tutorialMapX: CGFloat = 111.0
    var tutorialIconX: CGFloat = 29.0
    var tutorialDetailX: CGFloat = 188.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mySegcon = UISegmentedControl()
        mySegcon.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 50)
        mySegcon.tintColor = UIColor.blue
        
        
        // SegmentedControllerをviewに追加.
        self.view.addSubview(mySegcon)
        
        
        self.tutorialMapButton.frame = CGRect(x: tutorialMapX, y: startY, width: 92.0, height: 92.0)
        self.tutorialIconButton.frame = CGRect(x: tutorialIconX, y: startY, width: 74.0, height: 75.0)
        self.tutorialDetailButton.frame = CGRect(x: tutorialDetailX, y: startY, width: 62.0, height: 69.0)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animation(){
       
        UIView.animate(withDuration: 2.0, delay: 0.0,
                       
                       // バネの弾性力. 小さいほど弾性力は大きくなる.
            usingSpringWithDamping: 0.7,
            
            // 初速度.
            initialSpringVelocity: 0.0,
            
            // 一定の速度.
            options: UIViewAnimationOptions.curveLinear,
            
            animations: {
                self.tutorialMapButton.frame = CGRect(x: self.tutorialMapX, y: 230.0, width: 92.0, height: 92.0)
                self.tutorialIconButton.frame = CGRect(x: self.tutorialIconX, y: 185.0, width: 74.0, height: 75.0)
                self.tutorialDetailButton.frame = CGRect(x: self.tutorialDetailX, y: 167.0, width: 62.0, height: 69.0)
                
                
        })
        { (isFinished) in
            print(isFinished)
        }
    }
    
    
    
    
    @IBAction func BackToMapButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
