//
//  ViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/04/14.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit


class StartViewController: UIViewController {
    
    var number: Int = 0
    
    @IBOutlet weak var tutorialImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialImageView.image = nil
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeImages()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeImages() {
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer) in
            self.number += 1
            self.switchImageView()
          /*  self.tutorialImageView.alpha = 0.5
            UIView.animate(withDuration: 6.0, animations: {
                self.tutorialImageView.alpha = 1.0
            })*/
        }
        timer.fire()
    }

    func switchImageView(){
        switch number {
        case 1:
            self.tutorialImageView.image = UIImage(named: "MapTutorialScreen.png")
        case 2:
             self.tutorialImageView.image = UIImage(named: "MapTutorialScreenNo2.png")
        case 3:
             self.tutorialImageView.image = UIImage(named: "MapTutorialScreenNo3.png")
        case 4:
             self.tutorialImageView.image = UIImage(named: "MapTutorialScreenNo4.png")
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let viewController = storyboard.instantiateInitialViewController()
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window!?.rootViewController = viewController
            appDelegate?.window!?.makeKeyAndVisible()
            
        default:
            break
        }
    }
    
}
