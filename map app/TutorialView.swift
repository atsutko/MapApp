//
//  TutorialView.swift
//  map app
//
//  Created by Masuhara on 2017/05/26.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

class TutorialView: UIView {
    
    @IBOutlet weak var baseView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        print(CFGetRetainCount(self))
        
        let contentView = Bundle.main.loadNibNamed("TutorialView", owner: self, options: nil)?.first as! UIView
        contentView.frame = frame
        self.addSubview(contentView)
        
        print(CFGetRetainCount(self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("開放されました")
        print(CFGetRetainCount(self))
    }
    
    @IBAction func tapTutorialView() {
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        print(CFGetRetainCount(self))
        
        self.removeFromSuperview()
        
        print(CFGetRetainCount(self))
    }
    
}
