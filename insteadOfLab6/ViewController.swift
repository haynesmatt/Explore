//
//  ViewController.swift
//  insteadOfLab6
//
//  Created by Robert Reyes-Enamorado on 3/9/22.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI


class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let defaultAnnotation = MKPointAnnotation()

    let annotation2 = MKPointAnnotation()
    let annotation3 = MKPointAnnotation()
    let annotation4 = MKPointAnnotation()
    let annotation5 = MKPointAnnotation()
    let manager = CLLocationManager()
    
    var index = 0
    var selectedAnnotation: MKPointAnnotation!
    

    private func createButton() {
        
        let button = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        button.icon = .arrowOutline
        button.cornerRadius = 12
        button.backgroundColor = UIColor(red: 37/255.0, green: 90/255.0, blue: 181/255.0, alpha: 0.9)
        button.center = CGPoint(x: 360, y: 50)
        mapView.addSubview(button)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        
        manager.startUpdatingLocation()
        print("Location button tapped.")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {return}
            self.manager.stopUpdatingLocation()
        
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        defaultAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.001784, longitude: -78.789556)

        let region = MKCoordinateRegion(center:defaultAnnotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        

        mapView.delegate = self
        manager.delegate = self
        createButton()
 
        if (index == 1 ){
            self.title = "Buildings"
            createBuildingPoints()
        }
        if (index == 2) {
            self.title = "Parking Lots"
            createParkingPoints()
        }
        if (index == 5 ){
            self.title = "Parking Lots"
            ceateDiningPoints()
        }
    }

    // Launch Maps app when user taps pin drop
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedAnnotation = view.annotation as? MKPointAnnotation
        if (selectedAnnotation != nil) {
            print("tapped on annotation")
                print(selectedAnnotation.coordinate)
            
            // Configurations to send to maps app
            let placemark = MKPlacemark(coordinate: selectedAnnotation.coordinate, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            let regionDistance:CLLocationDistance = 500
            mapView.view(for: placemark)
            let regionSpan = MKCoordinateRegion(center: selectedAnnotation.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
                mapItem.name = selectedAnnotation.title
                mapItem.openInMaps(launchOptions: options)
        }
    }
    
    func ceateDiningPoints(){
        
        let locations = [
            ["title": "Teddy's ",                           "latitude": 43.00248, "longitude": -78.794472],
            ["title": "The Cellar",                         "latitude": 43.00242,  "longitude": -78.79453],
            ["title": "Governors Dining Center",            "latitude": 43.002366, "longitude": -78.794417],
            ["title": "Capen Café",                         "latitude": 43.001209, "longitude": -78.789798],
            ["title": "Tim Hortons at the Alfiero Center",  "latitude": 42.999694, "longitude": -78.78667],
            ["title": "Tim Hortons at Student Union",       "latitude": 43.001519, "longitude": -78.786464],
            ["title": "Union Marketplace & Eatery",         "latitude": 43.001367, "longitude": -78.786561],
            ["title": "Moe's at Student Union",             "latitude": 43.001418, "longitude": -78.786459],
            ["title": "Champa Sushi",                       "latitude": 43.001228, "longitude": -78.786426],
            ["title": "Pistachio's",                        "latitude": 43.001166, "longitude": -78.786501],
            ["title": "Jamba",                              "latitude": 43.001136, "longitude": -78.786533],
            ["title": "Starbuck's Coffee",                  "latitude": 43.00169, "longitude": -78.785573],
            ["title": "Young Chow",                         "latitude": 43.0017535, "longitude": -78.785147],
            ["title": "Poke Factory",                       "latitude": 43.0015035, "longitude": -78.785147],
            ["title": "Au Bon Pain",                        "latitude": 43.007004, "longitude": -78.785406],
            ["title": "Guac And Roll",                      "latitude": 43.008896, "longitude": -78.785675],
            ["title": "Crossroads Culinary Center",         "latitude": 43.00898, "longitude": -78.786147],
            ["title": "Wrap it Up",                         "latitude": 43.009009, "longitude": -78.785465],
            ["title": "Sizzles",                            "latitude": 43.009018, "longitude": -78.785546],
            ["title": "Perks",                              "latitude": 43.009077, "longitude": -78.785167],
            ["title": "Jamba",                              "latitude": 43.001136, "longitude": -78.786533],
            ["title": "Jamba",                              "latitude": 43.001136, "longitude": -78.786533],
            ["title": "Jamba",                              "latitude": 43.001136, "longitude": -78.786533]


            ]
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
    }
    
    func createBuildingPoints(){
        
        let locations = [
            ["title": "Mathematics Building",               "latitude": 43.00121031882114, "longitude": -78.79278288758773],
            ["title": "Dorsheimer Laboratory/Greenhouse",   "latitude": 42.9997846363507,  "longitude": -78.79203932840716],
            ["title": "Natural Sciences Complex",           "latitude": 43.00075237199376, "longitude": -78.79176007714069],
            ["title": "Fronczak Hall",                      "latitude": 43.00124738498162, "longitude": -78.79093494224631],
            ["title": "Cooke Hall",                         "latitude": 42.99999161375377, "longitude": -78.79144046642001],
            ["title": "Hochstetter Hall",                   "latitude": 42.99998932290844, "longitude": -78.79075204836911],
            ["title": "Norton Hall",                        "latitude": 43.00108719233058, "longitude": -78.78866198590958],
            ["title": "Ketter Hall Addition",               "latitude": 43.00276687574388, "longitude": -78.78830744586425],
            ["title": "Ketter Hall",                        "latitude": 43.00239270478161, "longitude": -78.7882067303352],
            ["title": "Bonner Hall",                        "latitude": 43.00151299915381, "longitude": -78.78814182250936],
            ["title": "Knox Lecture Hall",                  "latitude": 43.00102616307274, "longitude": -78.78788760240617],
            ["title": "O'Brian Hall",                       "latitude": 43.00041868236351, "longitude": -78.7880557036045],
            ["title": "Park Hall",                          "latitude": 42.99974500765016, "longitude": -78.78787231937633],
            ["title": "Davis Hall",                         "latitude": 43.00275310445728, "longitude": -78.78722128934005],
            ["title": "Jarvis Hall",                        "latitude": 43.0022999424851,  "longitude": -78.78708229062849],
            ["title": "Furnas Hall",                        "latitude": 43.00193146357522, "longitude": -78.7871072897764],
            ["title": "Bell Hall",                          "latitude": 43.00152980430693, "longitude": -78.78700336822934],
            ["title": "Baldy Hall",                         "latitude": 43.00036867584336, "longitude": -78.78708905010087],
            ["title": "Alfiero Center",                     "latitude": 42.99978012595931, "longitude": -78.78704266271411],
            ["title": "Jacobs Management Center",           "latitude": 42.99952212660576, "longitude": -78.78694942059825],
            ["title": "UB Commons",                         "latitude": 43.00162383193572, "longitude": -78.78488395695156],
            ["title": "Clemens Hall",                       "latitude": 43.00025853666757, "longitude": -78.78499950448409],
            ["title": "Baird Hall",                         "latitude": 43.00004420474259, "longitude": -78.78448597964672],

        ]
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
    }
    
    func createPrinterPoints () {
        
    }
    
    func createParkingPoints(){
        
        let locations = [
            ["title": "Creekside Village", "subtitle": "Student Apartment Lot",    "latitude": 43.011339, "longitude": -78.790019],
            ["title": "Flickinger Court", "subtitle": "Student Apartment Lot",     "latitude": 43.005895,  "longitude": -78.801005],
            ["title": "Flint East", "subtitle": "Student Apartment Lot",           "latitude": 42.997546, "longitude": -78.787251],
            ["title": "Flint West",  "subtitle": "Student Apartment Lot",          "latitude": 42.997742, "longitude": -78.790716],
            ["title": "Hadley Village", "subtitle": "Student Apartment Lot",       "latitude": 42.998637, "longitude": -78.794922],
            ["title": "South Lake Village", "subtitle": "Student Apartment Lot",   "latitude": 43.002144, "longitude": -78.777831],
            
            ["title": "Fargo",       "subtitle": "Residence Hall Lot",   "latitude": 43.006405, "longitude": -78.787122],
            ["title": "Governors B", "subtitle": "Residence Hall Lot",   "latitude": 43.002356, "longitude": -78.792486],
            ["title": "Governors C", "subtitle": "Residence Hall Lot",   "latitude": 43.003768, "longitude": -78.790362],
            ["title": "Governors D", "subtitle": "Residence Hall Lot",   "latitude": 43.003863, "longitude": -78.791993],
            ["title": "Governors E", "subtitle": "Residence Hall Lot",   "latitude": 43.003737, "longitude": -78.794096],
            ["title": "Red Jacket",  "subtitle": "Residence Hall Lot",   "latitude": 43.008586, "longitude": -78.787572],
            ["title": "Richmond B",  "subtitle": "Residence Hall Lot",   "latitude": 43.009935, "longitude": -78.788002],
            ["title": "Richmond A",  "subtitle": "Residence Hall Lot",   "latitude": 43.010359, "longitude": -78.78695],
            ["title": "Spaulding",   "subtitle": "Residence Hall Lot",   "latitude": 43.010594, "longitude": -78.783259],
            
            ["title": "Alumni B", "subtitle": "Park and Ride Lot",                  "latitude": 43.001901, "longitude": -78.77871],
            ["title": "Arena", "subtitle": "Park and Ride Lot",                     "latitude": 43.000857, "longitude": -78.779418],
            ["title": "Center For Tomorrow (CFT)", "subtitle": "Park and Ride Lot", "latitude": 42.993285, "longitude": -78.792808],
            ["title": "Stadium",  "subtitle": "Park and Ride Lot",                  "latitude": 42.997821, "longitude": -78.779655],
            
            ["title": "Alumni A",   "subtitle": "Arts, Athletics or Events Lot",           "latitude": 43.000716, "longitude": -78.780223],
            ["title": "Alumni C",  "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 43.001909, "longitude": -78.779976],
            ["title": "Arena",   "subtitle": "Arts, Athletics or Events Parking Lot",      "latitude": 43.000857, "longitude": -78.779418],
            ["title": "Baird A",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998558, "longitude": -78.784504],
            
            ["title": "Baird B",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998401, "longitude": -78.7871],
            ["title": "Jacobs A",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998511, "longitude": -78.788302],
            ["title": "Jacobs B",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998401, "longitude": -78.7871],
            ["title": "Jacobs C",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998574, "longitude": -78.786113]
//            ["title": "Baird A",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998558, "longitude": -78.784504],
//            ["title": "Baird A",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998558, "longitude": -78.784504],
//            ["title": "Baird A",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998558, "longitude": -78.784504],
//            ["title": "Baird A",   "subtitle": "Arts, Athletics or Events Parking Lot",    "latitude": 42.998558, "longitude": -78.784504]

            ]
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.subtitle = location["subtitle"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
    }
}
