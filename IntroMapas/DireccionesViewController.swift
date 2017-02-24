//
//  DireccionesViewController.swift
//  IntroMapas
//
//  Created by cice on 17/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import CoreLocation

class DireccionesViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var myLatitudLBL: UILabel!
    
    @IBOutlet weak var myLongitudLBL: UILabel!
    @IBOutlet weak var myRumboLBL: UILabel!
    @IBOutlet weak var myVelocidadLBL: UILabel!
    @IBOutlet weak var myAltitudLBL: UILabel!
    @IBOutlet weak var myDireccionLBL: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension DireccionesViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
       /* guard let userLocation = locations.fist else{
            return
        } */
        
        if let userLocation = locations.first{
            
            myLatitudLBL.text = "\(userLocation.coordinate.latitude)"
            myLongitudLBL.text = "\(userLocation.coordinate.longitude)"
            myRumboLBL.text = "\(userLocation.course)"
            myVelocidadLBL.text = "\(userLocation.speed)"
            myAltitudLBL.text = "\(userLocation.altitude)"
            
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
                
                if error != nil{
                    
                    print(error?.localizedDescription as Any)
                    
                }else{
                    
                    if let placemarkDes = placemarks?[0]{
                        
                        var direccion = ""
                        
                        direccion += self.addInfo(placemarkDes.thoroughfare)
                        direccion += self.addInfo(placemarkDes.subThoroughfare)
                        direccion += self.addInfo(placemarkDes.subLocality)
                        direccion += self.addInfo(placemarkDes.subAdministrativeArea)
                        direccion += self.addInfo(placemarkDes.isoCountryCode)
                        direccion += self.addInfo(placemarkDes.country)
                        direccion += self.addInfo(placemarkDes.postalCode)
                        direccion += self.addInfo(placemarkDes.locality)
                        
                        self.myDireccionLBL.text = direccion;
                        
                        
                        print(placemarkDes.thoroughfare!)
                    }
                    
                    
                }
                
                
            })
            
            
            
            
            
            
        }
        
        
        
        
    }
    
    func addInfo(_ info : String?) -> String{
        
        if info != nil{
            
            return "\(info!) \n"
        }
        return ""
    }
    
    
    
}
