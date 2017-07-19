//
//  MapViewController.swift
//  AmenityMap
//
//  Created by 高尾敦 on 2017/04/11
//  Copyright © 2017年 takao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import NCMB


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, ReactButtonDelegate {
    
    // Variables
    var amenities = [Amenity]()
    var annotations = [MKAnnotation]()
    var locationManager: CLLocationManager!
    var titleText: String = ""
    var commentText: String = ""
    var decisionColor: Int = 0
    var currentLocation: CGPoint?
    var isGood: String! = "Good"
    var locationHistory: Array<Double> = []
    var image: UIImage! = nil
    
    // Outlets
    @IBOutlet weak var mainMapView: MKMapView!
    
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMapView.delegate = self

        
        setUpLocationManager()
        setUpGestureRecognizer()
        
        loadAmenities()
        loadAnnotations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadAmenities()
        loadAnnotations()
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // LocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(lastLocation.coordinate, span)
            mainMapView.setRegion(region, animated: true)
            mainMapView.setCenter(mainMapView.userLocation.coordinate, animated: true)
            mainMapView.userTrackingMode = MKUserTrackingMode.follow
            mainMapView.showsUserLocation = true
        }
    }
    
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .authorizedWhenInUse:
            print("AuthorizedWhenInUse")
        case .authorized:
            print("Authorized")
        case .denied:
            print("Denied")
        case .restricted:
            print("Restricted")
        case .notDetermined:
            print("NotDetermined")
            
        }
    }
 
    
    // MapView Delegate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        } else {
            let reuseId = "Pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                
                // Todo: ここからアクセサリビューを付けて詳細に移動
                let toAmenityViewButton = UIButton()
                toAmenityViewButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                let image = UIImage(named: "倉敷.JPG")
                toAmenityViewButton.setImage(image, for: .normal)
                pinView?.rightCalloutAccessoryView = toAmenityViewButton
                toAmenityViewButton.addTarget(self, action: #selector(MapViewController.tapToAmenityViewButton(sender:)), for: .touchUpInside)
                
                // pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
                // pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                pinView?.image = UIImage(named: "red_flag_48px_501173_easyicon.net.png")
                
                
                pinView!.annotation = annotation
                
                
            } else {
                pinView!.annotation = annotation
            }
            
            if let title = annotation.subtitle {
                if let sub = title {
                    switch sub {
                    case "wifi":
                        let image = UIImage(named: "Wi-FiBlue.png")
                        let resizeImage = image?.resizeÜIImage(width: 30.0, height: 30.0)
                        pinView?.image = resizeImage
                    case "toilette":
                        let image = UIImage(named: "Toilette.png")
                        let resizeImage = image?.resizeÜIImage(width: 30.0, height: 30.0)
                        pinView?.image = resizeImage
                    case "ATM":
                        let image = UIImage(named: "ATMGreen.png")
                        let resizeImage = image?.resizeÜIImage(width: 30.0, height: 30.0)
                        pinView?.image = resizeImage
                    case "bicycle":
                        let image = UIImage(named: "BicycleIcon.png")
                        let resizeImage = image?.resizeÜIImage(width: 30.0, height: 30.0)
                        pinView?.image = resizeImage
                    case "consent":
                        let image = UIImage(named: "consent.png")
                        let resizeImage = image?.resizeÜIImage(width: 30.0, height: 30.0)
                        pinView?.image = resizeImage
                    case "open":
                        let image = UIImage(named: "24openOrange.png")
                        let resizeImage = image?.resizeÜIImage(width: 30.0, height: 30.0)
                        pinView?.image = resizeImage
                    default:
                        let image = UIImage(named: "red_flag_48px_501173_easyicon.net.png")
                        let resizeImage = image?.resizeÜIImage(width: 30.0, height: 30.0)
                        pinView?.image = resizeImage
                    }
                }
            }
            
            return pinView
        }
    }
    
    
    internal func tapToAmenityViewButton(sender: UIButton){
        self.performSegue(withIdentifier: "toAmenityViewController", sender: nil)
    }
    
    //アクセサリビューにつけたボタンをタップすると、AmenityViewControllerを表示
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAmenityViewController" {
            /* let amenityViewController = segue.destination as! AmenityViewController
             if Amenity.loadAmenities() != nil {
             
             }*/
        }
    }
    
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        // TODO: Show tutorial (Reference counting bug is remained. 3 countings remain after removeFromSuperView.)
        //コントローラーを除く
        //チュートリアルを作る
        
        //showTutorial()
        
    }
    
    
    // LongPress Gesture
    func recognizeLongPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state != UIGestureRecognizerState.began {
            return
        }
        
        let location = sender.location(in: mainMapView)
        let coordinate: CLLocationCoordinate2D = mainMapView.convert(location, toCoordinateFrom: mainMapView)
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = coordinate
        
        pin.title = title
        
        mainMapView.addAnnotation(pin)
        
        currentLocation = CGPoint(x: Double(pin.coordinate.longitude), y: Double(pin.coordinate.latitude))
        
        buildButton()
    }
    
    
    func buildButton() {
        let wifiButton = ReactionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100), reactionType: .wifi)
        wifiButton.delegate = self
        self.view.addSubview(wifiButton)
        
        let toiletteButton = ReactionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100), reactionType: .toilette)
        toiletteButton.delegate = self
        self.view.addSubview(toiletteButton)
        
        let ATMButton = ReactionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100), reactionType: .ATM)
        ATMButton.delegate = self
        self.view.addSubview(ATMButton)
        
        let bicycleButton = ReactionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100), reactionType: .bicycle)
        bicycleButton.delegate = self
        self.view.addSubview(bicycleButton)
        
        let consentButton = ReactionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100), reactionType: .consent)
        consentButton.delegate = self
        self.view.addSubview(consentButton)
        
        let openButton = ReactionButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100), reactionType: .open)
        openButton.delegate = self
        self.view.addSubview(openButton)
    }
    
    
    func buildCommentTextField() {
        let commentTextField: UITextField!
        let tWidth: CGFloat = 200
        let tHeight: CGFloat = 30
        let posX: CGFloat = (self.view.bounds.width - tWidth) / 2
        let posY: CGFloat = (self.view.bounds.height - tHeight) / 2
        
        commentTextField = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
        commentTextField.placeholder = "例：代官山駅前カフェ"
        commentTextField.delegate = self
        commentTextField.borderStyle = .roundedRect
        commentTextField.clearButtonMode = .whileEditing
        self.view.addSubview(commentTextField)
        
        commentTextField.becomeFirstResponder()
    }
    
    
    // UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        hideCommentTexiField()
        
        commentText = textField.text!
        if commentText != "" {
            if let location = currentLocation {
                
                // TODO: good or bad
                Amenity.saveAmenity(location: location, title: commentText, isGood: isGood)
                mainMapView.reloadInputViews()
                
            } else {
                print("位置情報が不明です。")
            }
        }
        
        
        textField.resignFirstResponder()
        return true
    }
    
    // Private
    private func hideCommentTexiField() {
        for view in self.view.subviews {
            if NSStringFromClass(type(of: view)) == "UITextField" {
                view.isHidden = true
            }
        }
    }
    
    private func loadAnnotations() {
        let query = NCMBQuery(className: "amenities")
        query?.findObjectsInBackground({(objects, error) in
            if (error != nil){
             
            }
            else{
              
                if let ams = objects as? [NCMBObject] {
                    for object in ams {
                        let longitude = object.object(forKey: "longitude") as! Double
                        let lantitude = object.object(forKey: "lantitude") as! Double
                        let title = object.object(forKey: "title") as! String
                        let isGood = object.object(forKey: "isGood") as! String
                        let annotation = AmenityLocation(name: title, lat: lantitude, long: longitude)
                        annotation.subtitle = isGood
                        self.annotations.append(annotation)
                    }
                    self.mainMapView.addAnnotations(self.annotations)
                    self.mainMapView.showAnnotations(self.annotations, animated: true)
                } else {
                    print("データがありません")
                }
            }
        })
    }
    private func setUpLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = 100.0
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let status = CLLocationManager.authorizationStatus()
        if status != CLAuthorizationStatus.authorizedWhenInUse {
            print ("not determined")
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    private func setUpGestureRecognizer() {
        let longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer()
        longPress.addTarget(self, action: #selector(MapViewController.recognizeLongPress(sender:)))
        mainMapView.addGestureRecognizer(longPress)
    }
    
    // ReactButton Delegate
    func didTapReactionButton(button: ReactionButton) {
       
        // 次のTODO: Reactionが保存されていないので保存するには...?
        
        switch button.tag {
        case 1:
            isGood = "wifi"
            ReactionButton.hideButtons(controller: self)
            buildCommentTextField()
            loadAnnotations()
        case 2:
            isGood = "toilette"
            ReactionButton.hideButtons(controller: self)
            buildCommentTextField()
            loadAnnotations()
        case 3:
            isGood = "ATM"
            ReactionButton.hideButtons(controller: self)
            buildCommentTextField()
            loadAnnotations()
        case 4:
            isGood = "bicycle"
            ReactionButton.hideButtons(controller: self)
            buildCommentTextField()
            loadAnnotations()
        case 5:
            isGood = "consent"
            ReactionButton.hideButtons(controller: self)
            buildCommentTextField()
            loadAnnotations()
        case 6:
            isGood = "open"
            ReactionButton.hideButtons(controller: self)
            buildCommentTextField()
            loadAnnotations()
            
        default :
            break
        }
    }
    
    func loadAmenities() {
        var amenities = [Amenity]()
        let query = NCMBQuery(className: "amenities")
        query?.findObjectsInBackground({(objects, error) in
            if error != nil {
                // 検索失敗時の処理
            }else{
                if let ams = objects as? [NCMBObject] {
                    for pinInfo in ams {
                        let longitude = pinInfo.object(forKey: "longitude") as! Double
                        let lantitude = pinInfo.object(forKey: "lantitude") as! Double
                        let title = pinInfo.object(forKey: "title") as! String
                        let isGood = pinInfo.object(forKey: "isGood") as! String
                        let amenity = Amenity(longitude: longitude, lantitude: lantitude, title: title, isGood: isGood)
                        amenities.append(amenity)
                    }
                    
                } else {
                    print("データがありません")
                }
            }
        })
    }
    
    @IBAction private func reloadMap() {
        // remove all annotations
        mainMapView.annotations.forEach {
            if !($0 is MKUserLocation) {
                mainMapView.removeAnnotation($0)
            }
        }
        
        // initialize
        amenities = [Amenity]()
        annotations = [MKAnnotation]()
        
        // reload
        loadAnnotations()
    }
    
    
}

extension UIImage{
    
    // Resizeするクラスメソッド.
    func resizeÜIImage(width : CGFloat, height : CGFloat)-> UIImage!{
        
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



