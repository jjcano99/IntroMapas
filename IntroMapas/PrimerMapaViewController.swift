//
//  PrimerMapaViewController.swift
//  IntroMapas
//
//  Created by cice on 17/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


enum MapaType : Int{
    case standard = 0
    case hibrido = 1
    case satelite = 2
    
}



class PrimerMapaViewController: UIViewController {
    
    
    var locationManager = CLLocationManager()
    
    
    
    
    
    
    @IBOutlet weak var mySegmentTipoMapa: UISegmentedControl!
    
    @IBOutlet weak var myPrimerMapa: MKMapView!
    
    @IBOutlet weak var myDescripcionDatosMapa: UILabel!
    
    
    @IBAction func muestraNuevoMapa(_ sender: AnyObject) {
        
        let mapa = MapaType(rawValue: mySegmentTipoMapa.selectedSegmentIndex)
        switch mapa! {
        case .standard:
            myPrimerMapa.mapType = MKMapType.standard
        case .hibrido:
            myPrimerMapa.mapType = MKMapType.hybrid
        case .satelite:
            myPrimerMapa.mapType = MKMapType.satellite
            break
        }
        
        
    }
    
    
    @IBAction func muestraMapa(_ sender: AnyObject) {
        
        //coordenadas
        
        let latitud = 40.389925
        let longitud = -3.760911
        
        //zoom
        let latDelta = 0.001
        
        let longDelta = 0.001
        
        //localizacion
        
        let location = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        
        myPrimerMapa.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Estamos en clse de iOS"
        annotation.subtitle = "Aquí currando"
        myPrimerMapa.addAnnotation(annotation)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
        //Creamos un gesto de reconocimiento
        
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(self.muestraGR(_:)))
        
        longPressGR.minimumPressDuration = 2
        
        myPrimerMapa.addGestureRecognizer(longPressGR)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func muestraGR(_ gesture : UIGestureRecognizer){
        
        if gesture.state == UIGestureRecognizerState.began{
            
             let puntoTocado = gesture.location(in: myPrimerMapa)
        let nuevaCoordenada = myPrimerMapa.convert(puntoTocado, toCoordinateFrom: myPrimerMapa)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = nuevaCoordenada
        
        annotation.title = "Nueva etiqueta en el mapa"
        
        annotation.subtitle = "Aquí seguimos currando"
    
        myPrimerMapa.addAnnotation(annotation)

            
        }
        
               
        
        
    }
    


}


extension PrimerMapaViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first!
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        let latDelta = 0.001
        let longDelta = 0.001
        let location = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        myPrimerMapa.setRegion(region, animated: true)
        myDescripcionDatosMapa.text = "\(userLocation)"
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation.coordinate
        annotation.title = "nueva etiqueta"
        myPrimerMapa.addAnnotation(annotation)
        
        
        
        
       
    }
  }

    








