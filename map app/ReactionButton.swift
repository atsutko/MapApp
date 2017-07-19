//
//  ReactionButton.swift
//  map app
//
//  Created by Masuhara on 2017/05/20.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

protocol ReactButtonDelegate {
    func didTapReactionButton(button: ReactionButton)
}

class ReactionButton: UIButton {
    
    enum ReactionType {
        case wifi
        case toilette
        case ATM
        case bicycle
        case consent
        case open
    }
    
    let bWidth: CGFloat = 44.4
    let bHeight: CGFloat = 44.4
    let posX: CGFloat = 17.0
    let posY: CGFloat = 90.0
    //let x1: CGFloat = 20.0
    let y0: CGFloat = 150.0
    //let x2: CGFloat = 197.0
    let y1: CGFloat = 210.0
    //let positionX: CGFloat = 287.0
    //let positionY: CGFloat = 500.0
    let y2: CGFloat = 270.0
    let y3: CGFloat = 330.0
    let y4: CGFloat = 390.0
    
    
    var delegate: ReactButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, reactionType: ReactionType) {
        self.init(frame: frame)
        
        switch reactionType {
        case .wifi:
            self.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
            let image = UIImage(named: "Wi-FiBlue.png")
            let resizeImage = image?.resizeImage(width: 44.4, height: 44.4)
            let backgroundButtonImage = resizeImage
            self.setImage(backgroundButtonImage, for: .normal)
            self.layer.cornerRadius = 22.2
            self.layer.masksToBounds = true
            self.addTarget(self, action: #selector(self.tapReactionButton(_:)), for: .touchUpInside)
            self.tag = 1
        case .toilette:
            self.frame = CGRect(x: posX, y: y0, width: bWidth, height: bHeight)
            let image = UIImage(named: "Toilette.png")
            let resizeImage = image?.resizeImage(width: 44.4, height: 44.4)
            let backgroundImageButtonImage = resizeImage
            self.setImage(backgroundImageButtonImage, for: .normal)
            self.layer.cornerRadius = 22.2
            self.layer.masksToBounds = true
            self.addTarget(self, action: #selector(self.tapReactionButton(_:)), for: .touchUpInside)
            self.tag = 2
        case .ATM:
            self.frame = CGRect(x: posX, y: y1, width: bWidth, height: bHeight)
            let image = UIImage(named: "ATMGreen.png")
            let resizeImage = image?.resizeImage(width: 44.4, height: 44.4)
            let backgroundImageButtonImage = resizeImage
            self.setImage(backgroundImageButtonImage, for: .normal)
            self.layer.cornerRadius = 22.2
            self.layer.masksToBounds = true
            self.addTarget(self, action: #selector(self.tapReactionButton(_:)), for: .touchUpInside)
            self.tag = 3
        case .bicycle:
            self.frame = CGRect(x: posX, y: y2, width: bWidth, height: bHeight)
            let image = UIImage(named: "BicycleIcon.png")
            let resizeImage = image?.resizeImage(width: 44.4, height: 44.4)
            let backgroundImageButtonImage = resizeImage
            self.setImage(backgroundImageButtonImage, for: .normal)
            self.layer.cornerRadius = 22.2
            self.layer.masksToBounds = true
            self.addTarget(self, action: #selector(self.tapReactionButton(_:)), for: .touchUpInside)
            self.tag = 4
        case .consent:
            self.frame = CGRect(x: posX, y: y3, width: bWidth, height: bHeight)
            let image = UIImage(named: "consent.png")
            let resizeImage = image?.resizeImage(width: 44.4, height: 44.4)
            let backgroundImageButtonImage = resizeImage
            self.setImage(backgroundImageButtonImage, for: .normal)
            self.layer.cornerRadius = 22.2
            self.layer.masksToBounds = true
            self.addTarget(self, action: #selector(self.tapReactionButton(_:)), for: .touchUpInside)
            self.tag = 5
        case .open:
            self.frame = CGRect(x: posX, y: y4, width: bWidth, height: bHeight)
            let image = UIImage(named: "24openOrange.png")
            let resizeImage = image?.resizeImage(width: 44.4, height: 44.4)
            let backgroundImageButtonImage = resizeImage
            self.setImage(backgroundImageButtonImage, for: .normal)
            self.layer.cornerRadius = 22.2
            self.layer.masksToBounds = true
            self.addTarget(self, action: #selector(self.tapReactionButton(_:)), for: .touchUpInside)
            self.tag = 6
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func hideButtons(controller: UIViewController) {
        for view in controller.view.subviews {
            print(NSStringFromClass(type(of: view)))
            if NSStringFromClass(type(of: view)) == "map_app.ReactionButton" {
                view.isHidden = true
            }
        }
    }
    
    @objc func tapReactionButton(_ button: ReactionButton) {
        self.delegate?.didTapReactionButton(button: button)
    }
    
    
}

extension UIImage{
    
    // Resizeするクラスメソッド.
    func resizeImage(width : CGFloat, height : CGFloat)-> UIImage!{
        
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        // コンテキストに自身に設定された画像を描画する.
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
