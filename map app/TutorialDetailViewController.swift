//
//  TutorialDetailViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/06/21.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit

class TutorialDetailViewController: UIViewController {

    var changeJudgeNumber: Int = 0
    
    
    @IBOutlet weak var DetailExplainTextView: UITextView!
    @IBOutlet weak var DetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeImageText()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeImageText(){
        switch changeJudgeNumber {
        case 0:
            DetailImageView.image = UIImage(named: "TableView.PNG")
            DetailExplainTextView.text = "Mapのところに書いた場所の一覧が表示されるよ！"
        case 1:
            DetailImageView.image = UIImage(named: "TableViewDelete.PNG")
            DetailExplainTextView.text = "左にスワイプすると、デリートできます！"
        case 2:
            DetailImageView.image = UIImage(named: "AmenityViewController.PNG")
            DetailExplainTextView.text = "カメラを使って、その場所の画像を撮ることができます！アルバムの中から画像をあげることもできます。詳細について書く欄も有効活用しよう！（例：wi-fiが弱い）"
        default:
            break
        }
    }
        @IBAction func BackButton() {
            changeJudgeNumber = changeJudgeNumber - 1
            changeImageText()
        }
        
        @IBAction func NextButton() {
            changeJudgeNumber = changeJudgeNumber + 1
            changeImageText()
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
