//
//  ViewController.swift
//  Pockemon
//
//  Created by Diana Manzano on 2/27/19.
//  Copyright © 2019 diana manzano. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{

    var mapView:GMSMapView!
    let locationManager = CLLocationManager()
    var listPockemon = [Pockemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadPockemons()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        self.view = mapView
        self.mapView.delegate = self
        
        // get user location
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        print("Tap at -> latitude: \(coordinate.latitude),longitude: \(coordinate.longitude)")
        self.listPockemon.append(Pockemon(latitude: coordinate.latitude, longitude: coordinate.longitude, image: "charmander", name: "Charmander", des: "Charmander lives in japan", power:55))
        
        for pockemon in listPockemon{
            
            if pockemon.isCatch == false {
                
                
                let markerpockemon = GMSMarker()
                markerpockemon.position = CLLocationCoordinate2D(latitude: pockemon.latitude!, longitude: pockemon.longitude!)
                markerpockemon.title = pockemon.name!
                markerpockemon.snippet = "\(pockemon.des!), power \(pockemon.power!)"
                markerpockemon.icon = UIImage(named:pockemon.image!)
                markerpockemon.map = self.mapView
            
                }
            }
    }
    
    var myLocatin = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        myLocatin = manager.location!.coordinate
        print("myLocatin: \(myLocatin)")
        self.mapView.clear()
        // my location
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2D(latitude: myLocatin.latitude, longitude: myLocatin.longitude)
        markerMe.title = "Me"
        markerMe.snippet = "here is my location"
        markerMe.icon = UIImage(named:"ashketchum")
        markerMe.map = self.mapView
        
        
        // show pockemons
        var index = 0
        
        for pockemon in listPockemon{
            
            if pockemon.isCatch == false {
                
            
                let markerpockemon = GMSMarker()
                markerpockemon.position = CLLocationCoordinate2D(latitude: pockemon.latitude!, longitude: pockemon.longitude!)
                markerpockemon.title = pockemon.name!
                markerpockemon.snippet = "\(pockemon.des!), power \(pockemon.power!)"
                markerpockemon.icon = UIImage(named:pockemon.image!)
                markerpockemon.map = self.mapView
                
                // catch pockemon
                if(Double (myLocatin.latitude).roundTo(places: 4) == Double(pockemon.latitude!).roundTo(places: 4) && Double (myLocatin.longitude).roundTo(places: 4) == Double(pockemon.longitude!).roundTo(places: 4)){
                    listPockemon[index].isCatch = true
                    AlertDialog(PockemonPower: pockemon.power!)
                }
            }
            
            index = index + 1
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: myLocatin.latitude, longitude: myLocatin.longitude, zoom: 15)
        self.mapView.camera = camera
        
    }
    
    var playerPower:Double = 0.0
    
    func LoadPockemons(){
        self.listPockemon.append(Pockemon(latitude: 37.7789994893035, longitude: -122.401846647263, image: "charmander", name: "Charmander", des: "Charmander lives in japan", power:55))
        self.listPockemon.append(Pockemon(latitude: 37.7949568502667, longitude: -122.410494089127, image: "pikachu", name: "Pikachu", des: "Pikachu lives in usa", power:90.5))
        self.listPockemon.append(Pockemon(latitude: 37.7816621152613, longitude: -122.41225361824, image: "bulbasaur", name: "Bulbasaur", des: "Bulbasaur lives in iraq", power:33.5))
        self.listPockemon.append(Pockemon(latitude: 37.7939874493035, longitude: -122.401846457263, image: "squirtle", name: "Squirtle", des: "Squirtle lives in méxico", power:65.5))
    }
    
    func AlertDialog(PockemonPower:Double){
        playerPower = playerPower + PockemonPower
        let alert = UIAlertController(title: "Catch new pockemon", message: "your new power is \(playerPower)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {action in
            //code here
            print(" + one")
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
extension Double{
    func roundTo(places:Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded()/divisor
    }
}

