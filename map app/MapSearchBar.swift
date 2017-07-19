//
//  MapSearchBar.swift
//  map app
//
//  Created by 高尾敦 on 2017/07/11.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

protocol MapSearchDelegate {
    func LocalSearch(searchbar: MapSearchBar)
}

class MapSearchBar: UISearchBar {
    
    let x: CGFloat = 10.0
    let y: CGFloat = 10.0
    let searchWidth: CGFloat = 10.0
    let searchHeight: CGFloat = 10.0
    
    
  /*  MapSearchBar.layer.position = CGPoint(x: self.view.frame.width/2, y: 80)
    MapSearchBar.layer.shadowColor = UIColor.blue.cgColor
    MapSearchBar.layer.shadowOpacity = 0.5
    MapSearchBar.layer.masksToBounds = false
    MapSearchBar.showsCancelButton = true
    MapSearchBar.showsBookmarkButton = false
    MapSearchBar.prompt = "ローカル検索"
    MapSearchBar.placeholder = "ここに入力してください"
    MapSearchBar.tintColor = UIColor.red
    MapSearchBar.showsSearchResultsButton = false

    var delegate: MapSearchDelegate?
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 編集終了.
        self.view.endEditing(true)
        
        // request生成.
        let myRequest: MKLocalSearchRequest = MKLocalSearchRequest()
        
        // 範囲を指定.
        myRequest.region = myRegion
        
        // 検索するワードをsearchBarのテキストに指定.
        myRequest.naturalLanguageQuery = searchBar.text
        
        // LocalSearchを生成.
        let mySearch: MKLocalSearch = MKLocalSearch(request: myRequest)
        
        // 検索開始.
        mySearch.start { (response, error) -> Void in
            
            if error != nil {
                print("地名無し")
            }
            else if response!.mapItems.count > 0 {
                for item in response!.mapItems {
                    
                    // 検索結果の内名前を出力.
                    print(item.name)
                }
            }
        }
    }
    
    /*
     Cancelボタンが押された時に呼ばれる.
     */
    func MapSearchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        MapSearchBar.text = ""
    }
    */
/*
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
*/

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
