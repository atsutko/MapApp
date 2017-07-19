//
//  TableViewController.swift
//  map app
//
//  Created by 高尾敦 on 2017/04/14.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import NCMB

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var amenities = [Amenity]()
    
    
    @IBOutlet weak var amenityTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        amenityTableView.dataSource = self
        amenityTableView.delegate = self
        
        amenityTableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadAmenities()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amenities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = amenities[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let alert = UIAlertController(title: "削除完了", message: "\(amenities[indexPath.row].title) を削除しました。\nマップに戻ってリロードして下さい。", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            
            // TestClassクラスを検索するNCMBQueryを作成
            let query = NCMBQuery(className: "amenities")
            /** 条件を入れる場合はここに書きます **/
            query?.whereKey("title", equalTo: "\(amenities[indexPath.row].title)")
            // データストアの検索を実施
            query?.findObjectsInBackground({(objects, error) in
                if error != nil {
                    // 検索失敗時の処理
                }else{
                    // 検索成功時の処理
                    if let obj = objects as? [NCMBObject]{
                        for deleteObj in obj{
                            deleteObj.deleteInBackground({ (error) in
                                if error != nil {
                                    // 削除に失敗した場合の処理
                                    print("delete error")
                                }else{
                                    // 削除に成功した場合の処理
                                    print("delete success")
                                }
                                
                                
                            })
                        }
                    }
                }
            })
            amenities.remove(at: indexPath.row)
        }
    }
    
    
    
    func loadAmenities() {
        var amenitiesArray = [Amenity]()
        let query = NCMBQuery(className: "amenities")
        query?.findObjectsInBackground({(objects, error) in
            if error != nil {
                // 検索失敗時の処理
            }else{
                if let ams = objects as? [NCMBObject] {
                    for object in ams {
                        let longitude = object.object(forKey: "longitude") as! Double
                        let lantitude = object.object(forKey: "lantitude") as! Double
                        let title = object.object(forKey: "title") as! String
                        let isGood = object.object(forKey: "isGood") as! String
                        let amenity = Amenity(longitude: longitude, lantitude: lantitude, title: title, isGood: isGood)
                        amenitiesArray.append(amenity)
                        self.amenities = amenitiesArray
                        
                    }
                    
                } else {
                    print("データがありません")
                }
            }
        })
        amenityTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = amenityTableView.indexPathForSelectedRow {
            let amenityViewController = segue.destination as! AmenityViewController
            // TestClassクラスを検索するNCMBQueryを作成
            let query = NCMBQuery(className: "amenities")
            /** 条件を入れる場合はここに書きます **/
            query?.whereKey("title", equalTo: "\(amenities[selectedIndexPath.row].title)")
            // データストアの検索を実施
            query?.findObjectsInBackground({(objects, error) in
                if error != nil {
                    // 検索失敗時の処理
                }else{
                    // 検索成功時の処理
                    if let obj = objects as? [NCMBObject]{
                        for object in obj{
                            let title = object.object(forKey: "title") as! String
                            let isGood = object.object(forKey: "isGood") as! String
                            amenityViewController.placeTitle = title
                            amenityViewController.kindPlace = isGood
                        }
                    }
                    
                }
            })
      
        }
    }
}
