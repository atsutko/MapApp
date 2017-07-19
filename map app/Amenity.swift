//
//  Amenity.swift
//  map app
//
//  Created by Masuhara on 2017/05/20.
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import CoreLocation
import NCMB

class Amenity: NSObject {
    
    var longitude: Double
    var lantitude: Double
    var title: String
    var evaluation: String?
    var isGood: String?
    var image: UIImage?
    
    
    init(longitude: Double, lantitude: Double, title: String, isGood: String) {
        self.longitude = longitude
        self.lantitude = lantitude
        self.title = title
        self.isGood = isGood
    }
    
    /*   required init?(coder aDecoder: NSCoder) {
     self.longitude = aDecoder.decodeDouble(forKey: "longitude")
     self.lantitude = aDecoder.decodeDouble(forKey: "lantitude")
     self.title = aDecoder.decodeObject(forKey: "title") as! String
     self.evaluation = aDecoder.decodeObject(forKey: "evaluation") as? String
     self.isGood = aDecoder.decodeObject(forKey: "isGood") as? String
     self.image = aDecoder.decodeObject(forKey: "image") as? UIImage
     }
     
     func encode(with aCoder: NSCoder) {
     aCoder.encode(longitude, forKey: "longitude")
     aCoder.encode(lantitude, forKey: "lantitude")
     aCoder.encode(title, forKey: "title")
     aCoder.encode(evaluation, forKey: "evaluation")
     aCoder.encode(isGood, forKey: "isGood")
     aCoder.encode(image, forKey: "image")
     }
     */
    

    
    /*   static func removeAmenity(index: Int) {
     let ud = UserDefaults.standard
     if let data = ud.data(forKey: "amenities") {
     var array = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Amenity]
     array.remove(at: index)
     let data = NSKeyedArchiver.archivedData(withRootObject: array)
     ud.set(data, forKey: "amenities")
     ud.synchronize()
     }
     }*/
    
    static func saveAmenity(location: CGPoint, title: String, isGood: String) {
        
        let amenity = Amenity(longitude: Double(location.x), lantitude: Double(location.y), title: title, isGood: isGood)
        
        let obj = NCMBObject(className: "amenities")
        obj?.setObject(amenity.longitude, forKey: "longitude")
        obj?.setObject(amenity.lantitude, forKey: "lantitude")
        obj?.setObject(amenity.title, forKey: "title")
        obj?.setObject(amenity.isGood, forKey: "isGood")
        
        
        obj?.saveInBackground({ (error)in
            if error != nil{
                print("error")
            }else{
                
            }
            
        })
        
        /* let ud = UserDefaults.standard
         if ud.data(forKey: "amenities") != nil {
         
         // Get data object which is array of Amenity
         let saveData = ud.data(forKey: "amenities")!
         var array = NSKeyedUnarchiver.unarchiveObject(with: saveData) as! [Amenity]
         array.append(amenity)
         let data = NSKeyedArchiver.archivedData(withRootObject: array)
         ud.set(data, forKey: "amenities")
         } else {
         var newArray = [Amenity]()
         newArray.append(amenity)
         let data = NSKeyedArchiver.archivedData(withRootObject: newArray)
         ud.set(data, forKey: "amenities")
         }
         
         ud.synchronize()*/
    }
    
    static func removeAll() {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "amenities")
        ud.synchronize()
    }
    
}
