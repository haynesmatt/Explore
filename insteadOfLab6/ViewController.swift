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
        
        let button = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        button.icon = .arrowOutline
        button.cornerRadius = 12
        button.backgroundColor = UIColor(red: 37/255.0, green: 90/255.0, blue: 181/255.0, alpha: 0.9)
        button.center = CGPoint(x: 348, y: 80)
        
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
        if (index == 3){
            self.title = "Student Housing"
            createHousingPoints()
        }
        if (index == 4){
            self.title = "Bike Racks"
            createBikeRackPoints()
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // do not alter user location marker
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }

        // get existing marker
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "reuseIdentifier") as? MKMarkerAnnotationView

        // is this a new marker (i.e. nil)?
        if view == nil {
            view = MKMarkerAnnotationView(annotation: nil, reuseIdentifier: "reuseIdentifier")
        }
        // set subtitle to show without being selected
        view?.subtitleVisibility = .visible

        // just for fun, show green markers where subtitles exist; red otherwise
        
            view?.markerTintColor = UIColor(red: 37/255.0, green: 90/255.0, blue: 181/255.0, alpha: 0.9)
        
        return view
    }
    
    
    func createHousingPoints() {
        
        let locations = [
            ["title": "Flickinger Court 1 - Commons",  "latitude": 43.00521836974938, "longitude": -78.80085319707071],
            ["title": "Flickinger Court 2",  "latitude": 43.00476571956016, "longitude": -78.80172618632668],
            ["title": "Flickinger Court 3",  "latitude": 43.00538028518405, "longitude": -78.80125230329205],
            ["title": "Flickinger Court 4",  "latitude": 43.00531678120194, "longitude": -78.80174354872131],
            ["title": "Flickinger Court 6",  "latitude": 43.00587027632461, "longitude": -78.80172977676847],
            ["title": "Flickinger Court 8",  "latitude": 43.00620600650298, "longitude": -78.80136273284974],
            ["title": "Flickinger Court 10",  "latitude": 43.00633409327107, "longitude": -78.80077550498716],
            ["title": "Flickinger Court 12",  "latitude": 43.0061835208444, "longitude": -78.80022667182251],
            ["title": "Flickinger Court 14",  "latitude": 43.00578992544747, "longitude": -78.8000612674861],
            ["title": "Flickinger Court 16",  "latitude": 43.00561976681727, "longitude": -78.79980945216153],
            ["title": "Flickinger Court 18",  "latitude": 43.00542689115301, "longitude": -78.7992285092122],
            ["title": "Flickinger Court 20",  "latitude": 43.00502068485338, "longitude": -78.79946705874529],
            ["title": "Flickinger Court 22",  "latitude": 43.0050646316544, "longitude": -78.80010284652902],
            ["title": "Flickinger Court 24",  "latitude": 43.00471232202039, "longitude": -78.80022176422654],
            
            ["title": "Flickinger Court 8",  "latitude": 43.00620600650298, "longitude": -78.80136273284974],
            ["title": "Flickinger Court 8",  "latitude": 43.00620600650298, "longitude": -78.80136273284974],
            ["title": "Flickinger Court 8",  "latitude": 43.00620600650298, "longitude": -78.80136273284974],

            ["title": "Hadley Village 90 - Commons",  "latitude": 43.00521836974938, "longitude": -78.80085319707071],
            ["title": "Hadley Village 101",  "latitude": 42.99873854262977, "longitude": -78.79531643663263],
            ["title": "Hadley Village 102",  "latitude": 42.99845901037686, "longitude": -78.79527488896996],
            ["title": "Hadley Village 103",  "latitude": 42.99816234478807, "longitude": -78.795024052218],
            ["title": "Hadley Village 104",  "latitude": 42.99786082640693, "longitude": -78.79481097653664],
            ["title": "Hadley Village 105",  "latitude": 42.99784067413462, "longitude": -78.79525468491757],
            ["title": "Hadley Village 106",  "latitude": 42.99812082581875, "longitude": -78.7955146069804],
            ["title": "Hadley Village 107",  "latitude": 42.99842333055094, "longitude": -78.79572130061335],
            ["title": "Hadley Village 108",  "latitude": 42.99873707226002, "longitude": -78.79577055550443],
            ["title": "Hadley Village 109",  "latitude": 42.99918494485746, "longitude": -78.79576916755745],
            ["title": "Hadley Village 110",  "latitude": 42.99946030759372, "longitude": -78.79570101999495],
            ["title": "Hadley Village 111",  "latitude": 42.99946177891948, "longitude": -78.79524597729693],
            ["title": "Hadley Village 112",  "latitude": 42.9993259183593, "longitude": -78.79481030798402],
            ["title": "Hadley Village 113",  "latitude": 42.99918675006794, "longitude": -78.79531456128186],

            ["title": "Dewey Hall",  "latitude": 43.0026100191545, "longitude": -78.79488330337522],
            ["title": "Roosevelt Hall",  "latitude": 43.00260265019647, "longitude": -78.79448958067525],
            ["title": "Clinton Hall",  "latitude": 43.00174790590636, "longitude": -78.79487993283561],
            ["title": "Lehman Hall",  "latitude": 43.00176964274157, "longitude": -78.79448998597044],

            ["title": "Creekside Village 812 - Commons",  "latitude": 43.01106990074415, "longitude": -78.79074903989111],
            ["title": "Creekside Village 801",  "latitude": 43.01089755459849, "longitude": -78.78964587595914],
            ["title": "Creekside Village 803",  "latitude": 43.01049806667865, "longitude": -78.78940422824458],
            ["title": "Creekside Village 805",  "latitude": 43.01042268915312, "longitude": -78.79000561655563],
            ["title": "Creekside Village 807",  "latitude": 43.01043373971012, "longitude": -78.79062465854662],
            ["title": "Creekside Village 809",  "latitude": 43.01015098856744, "longitude": -78.79108315852591],
            ["title": "Creekside Village 811",  "latitude": 43.01047542675084, "longitude": -78.79154313274873],
            ["title": "Creekside Village 813",  "latitude": 43.01157718541734, "longitude": -78.79191214025705],
            ["title": "Creekside Village 815",  "latitude": 43.01183957676017, "longitude": -78.79236299554755],
            ["title": "Creekside Village 817",  "latitude": 43.01156365333409, "longitude": -78.79322482652211],
            ["title": "Creekside Village 819",  "latitude": 43.01198081723288, "longitude": -78.79321835455399],
            ["title": "Creekside Village 821",  "latitude": 43.01210005152495, "longitude": -78.79268673231771],
            ["title": "Creekside Village 823",  "latitude": 43.01072718124556, "longitude": -78.7932993750407],
            ["title": "Creekside Village 825",  "latitude": 43.01118982177454, "longitude": -78.79344360957067],

            ["title": "Flint Village 300 - Commons",  "latitude": 42.99764873597498, "longitude": -78.78723685526097],
            ["title": "Flint Village 301",  "latitude": 42.99744953312842, "longitude": -78.7861587314811],
            ["title": "Flint Village 302",  "latitude": 42.99731997376152, "longitude": -78.78721764433897],
            ["title": "Flint Village 303",  "latitude": 42.9970219856724, "longitude": -78.78809116229859],
            ["title": "Flint Village 304",  "latitude": 42.99659527591015, "longitude": -78.78884137896456],
            ["title": "Flint Village 305",  "latitude": 42.99638852138416, "longitude": -78.78990033274181],
            ["title": "Flint Village 306",  "latitude": 42.99715417809208, "longitude": -78.7888725190308],
            ["title": "Flint Village 307",  "latitude": 42.99747791839462, "longitude": -78.78845728876794],
            ["title": "Flint Village 308",  "latitude": 42.99740854887985, "longitude": -78.79049452651981],
            ["title": "Flint Village 309",  "latitude": 42.99739248565093, "longitude": -78.79152285235753],
            
            ["title": "Spaulding Quadrangle",  "latitude": 43.00948557407369, "longitude": -78.78448464138238],
            ["title": "Richmond Quadrangle",  "latitude": 43.00939117561037, "longitude": -78.78547723281221],
            ["title": "Red Jacket Quadrangle",  "latitude": 43.00886928675621, "longitude": -78.78628489264533],
            ["title": "Wilkeson Quadrangle",  "latitude": 43.00844423144911, "longitude": -78.78363910537675],
            ["title": "Evans Quadrangle",  "latitude": 43.00766467291333, "longitude": -78.78642649403611],
            ["title": "Fargo Quadrangle",  "latitude": 43.00760708365682, "longitude": -78.78565703876664],
            ["title": "Greiner Hall",  "latitude": 43.00640488568724, "longitude": -78.7854836087534],

            ["title": "South Lake Village 211 - Commons",  "latitude": 43.00306261560579, "longitude": -78.77892272092522],
            ["title": "South Lake Village 201",  "latitude": 43.00248088893211, "longitude": -78.77848799061096],
            ["title": "South Lake Village 202",  "latitude": 43.00189716091946, "longitude": -78.77728765193997],
            ["title": "South Lake Village 203",  "latitude": 43.00233383388083, "longitude": -78.77780138298468],
            ["title": "South Lake Village 204",  "latitude": 43.00196982769939, "longitude": -78.77671866847427],
            ["title": "South Lake Village 205",  "latitude": 43.0026387903529, "longitude": -78.77751147700251],
            ["title": "South Lake Village 206",  "latitude": 43.00214146090466, "longitude": -78.77619577851885],
            ["title": "South Lake Village 207",  "latitude": 43.00296327117162, "longitude": -78.77806707450384],
            ["title": "South Lake Village 208",  "latitude": 43.0027766780547, "longitude": -78.77452539142074],
            ["title": "South Lake Village 209",  "latitude": 43.00338060116224, "longitude": -78.77870686784618],
            ["title": "South Lake Village 210",  "latitude": 43.00259611554424, "longitude": -78.77509750942656],
            ["title": "South Lake Village 211",  "latitude": 43.00214146090466, "longitude": -78.77619577851885],
            ["title": "South Lake Village 212",  "latitude": 43.00253306028835, "longitude": -78.77570531805729],
            ["title": "South Lake Village 213",  "latitude": 43.00277968392563, "longitude": -78.77948737145667],
            ["title": "South Lake Village 214",  "latitude": 43.00258588084868, "longitude": -78.77631984568231],
            ["title": "South Lake Village 216",  "latitude": 43.00278137375366, "longitude": -78.77687960318573],
            ["title": "South Lake Village 218",  "latitude": 43.00306629760113, "longitude": -78.77734289021723],
            ["title": "South Lake Village 220",  "latitude": 43.00341454048918, "longitude": -78.77775839019228],
            ]
            for location in locations {
                let annotation = MKPointAnnotation()
                annotation.title = location["title"] as? String
                annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
                mapView.addAnnotation(annotation)
            }
    }
    
    
    
    func createBikeRackPoints () {
        let locations = [
            ["title": "Flint Right A",                           "latitude": 42.997519, "longitude": -78.787838],
            ["title": "Flint Right B",                           "latitude": 42.997484, "longitude": -78.787222],
            ["title": "Flint Right C",                           "latitude": 42.997616, "longitude": -78.786243],
            ["title": "Governor's A",                           "latitude": 43.002119, "longitude": -78.794910    ],
            ["title": "Governor's B",                           "latitude": 43.002616, "longitude": -78.794911    ],
            ["title": "Governor's C",                           "latitude": 42.997519, "longitude": -78.794682],
            ["title": "Governor's D",                           "latitude": 42.997519, "longitude": -78.794682],
            ["title": "Flint Loop A",                           "latitude": 43.000169, "longitude": -78.788812],
            ["title": "Baldy (Promenade)",                           "latitude": 43.000521, "longitude": -78.787071],
            
            ["title": "Hadley A",                           "latitude": 42.998898, "longitude": -78.796032],
            ["title": "Hadley B",                           "latitude": 42.997986, "longitude": -78.794535],
            ["title": "Hadley C",                           "latitude": 42.998895, "longitude": -78.794974],
            ["title": "Hadley D",                           "latitude": 42.999626, "longitude": -78.794593],
            
            ["title": "Hadley E",                           "latitude": 43.000521, "longitude": -78.790611],
            
            ["title": "Ellicott A",                           "latitude": 43.008850, "longitude": -78.786855],
            ["title": "Ellicott B",                           "latitude": 43.007775, "longitude": -78.786505],
            ["title": "Ellicott C",                           "latitude": 43.009507, "longitude": -78.785852],
            ["title": "Ellicott D",                           "latitude": 43.009836, "longitude": -78.785477],
            ["title": "Ellicott E",                           "latitude": 43.009739, "longitude": -78.784167],
            ["title": "Ellicott F",                           "latitude": 43.008777, "longitude": -78.783494],
            ["title": "Ellicott G",                           "latitude": 43.007448, "longitude": -78.786048],
            ["title": "Ellicott H",                           "latitude": 43.007176, "longitude": -78.785265],
            ["title": "Ellicott I",                           "latitude": 43.007074, "longitude": -78.785149],
            ["title": "Ellicott J",                           "latitude": 43.005902, "longitude": -78.785690],
            ["title": "Ellicott K",                           "latitude": 43.005902, "longitude": -78.785754],
            ["title": "Ellicott L",                           "latitude": 43.005872, "longitude": -78.785732],
            
            ["title": "Computing Center",                           "latitude": 43.001264, "longitude": -78.791127],
            
            ["title": "Cooke A",                           "latitude": 42.999657, "longitude": -78.791377],
            ["title": "Cooke B",                           "latitude": 42.999658, "longitude": -78.791481],
            
            ["title": "Hochstetter A",                           "latitude": 42.999661, "longitude": -78.790808],
            ["title": "Hochstetter B",                           "latitude": 42.999660, "longitude": -78.790712],

            
            ["title": "Capen Lower",                           "latitude": 43.001130, "longitude": -78.789848],
            ["title": "Capen Upper",                           "latitude": 43.001143, "longitude": -78.789144],
            
            ["title": "Norton",                           "latitude": 43.000904, "longitude": -78.788895],
            ["title": "Knox",                           "latitude": 43.000776, "longitude": -78.787943],
            ["title": "Park A",                           "latitude": 42.999914, "longitude": -78.787573],
            ["title": "Baldy A",                           "latitude": 43.000521, "longitude": -78.786515],
            ["title": "Lockwood",                           "latitude": 43.000405, "longitude": -78.785946],
            ["title": "Clemens",                           "latitude": 43.000308, "longitude": -78.785203],
            ["title": "Baird",                           "latitude": 42.999719, "longitude": -78.784068],
            ["title": "Alumni A",                           "latitude": 43.000492, "longitude": -78.780302],

            ["title": "South Lake A",                           "latitude": 43.002292, "longitude": -78.777137],
            ["title": "South Lake B",                           "latitude": 43.002332, "longitude": -78.776862],
            ["title": "South Lake C",                           "latitude": 43.002437, "longitude": -78.777103],
            
            ["title": "Student Union A",                           "latitude": 43.001575, "longitude": -78.785883],
            ["title": "Bookstore",                           "latitude": 43.002917, "longitude": -78.784829],
            ["title": "Davis",                           "latitude": 43.002746, "longitude": -78.786819],
            ["title": "Ketter A",                           "latitude": 43.002210, "longitude": -78.788538],
            ["title": "Beane Center",                           "latitude": 42.994092, "longitude": -78.795964],

            ["title": "Flint Village",                           "latitude": 42.997284, "longitude": -78.790995],
            ["title": "Furnas B",                           "latitude": 43.002025, "longitude": -78.787313],
            ["title": "Ketter B",                           "latitude": 43.002442, "longitude": -78.787919],
            ["title": "Baldy B",                           "latitude": 43.000248, "longitude": -78.787284],

            ["title": "Alumni B",                           "latitude": 43.000252, "longitude": -78.782231],
            ["title": "Alumni C",                           "latitude": 43.000252, "longitude": -78.782324],

            ["title": "Park B",                           "latitude": 43.000033, "longitude": -78.788548],
            ["title": "Student Union B",                           "latitude": 43.001394, "longitude": -78.785668],

            ["title": "Lockwood",                           "latitude": 43.000253, "longitude": -78.786220],
            ["title": "Center for the Arts",                "latitude": 43.000510, "longitude": -78.782946],
            ["title": "Bell A",                           "latitude": 43.001232, "longitude": -78.787160],
            ["title": "Bell B",                           "latitude": 43.001204, "longitude": -78.787227],
            ["title": "Cooke C",                           "latitude": 43.000320, "longitude": -78.791488],
            ["title": "Cooke D",                           "latitude": 43.000320, "longitude": -78.791389],
            ["title": "Hochstetter C",                           "latitude": 43.000318, "longitude": -78.790819],
            ["title": "Hochstetter D",                           "latitude": 43.000315, "longitude": -78.790708],

            ["title": "Governor's E",                           "latitude": 43.002124, "longitude": -78.794453],
            ["title": "Governor's F",                           "latitude": 43.002244, "longitude": -78.794459],

            ["title": "Lee Loop Bus Stop",                           "latitude": 43.001958, "longitude": -78.786010],
            ["title": "Norton East",                           "latitude": 43.000912, "longitude": -78.788371],
            ["title": "Governor's G",                           "latitude": 43.002139, "longitude": -78.793554],
            ["title": "Hadley F",                           "latitude": 42.999021, "longitude": -78.796031],
            ["title": "Hadley G",                           "latitude": 42.998586, "longitude": -78.796036],
            
            ["title": "NSC A",                           "latitude": 43.000486, "longitude": -78.791706],
            ["title": "Math Building",                           "latitude": 43.001355, "longitude": -78.792616],
            ["title": "Capen (North)",                           "latitude": 43.001169, "longitude": -78.789849],
            ["title": "O'Brian (Promenade)",                           "latitude": 43.000578, "longitude": -78.788274],
            ["title": "Alfiero",                           "latitude": 42.999646, "longitude": -78.786452],
            ["title": "Crofts's",                           "latitude": 42.994713, "longitude": -78.795181],
            ["title": "Center for Tomorrow Shuttle",                           "latitude": 42.993800, "longitude": -78.792908],

            ["title": "Flint Loop B",                           "latitude": 43.000015, "longitude": -78.789453],
            ["title": "Student Union (Promenade) A",                           "latitude": 43.000836, "longitude": -78.786591],
            ["title": "Student Union (Promenade) B",                           "latitude": 43.000837, "longitude": -78.786467],
            ["title": "Student Union (Promenade) C",                           "latitude": 43.000838, "longitude": -78.786015],
            ["title": "Lockwood (Mary Talbert Way)",                           "latitude": 42.999941, "longitude": -78.786280],
            ["title": "Slee",                           "latitude": 43.000469, "longitude": -78.783722],
            ["title": "Rensch Loop",                           "latitude": 42.999722, "longitude": -78.793073],
            ["title": "NSC B",                           "latitude": 43.000486, "longitude": -78.791748],
            ["title": "Bonner",                           "latitude": 43.001648, "longitude": -78.788467],
            ["title": "Wilkeson",                           "latitude": 43.008898, "longitude": -78.783380],

            ["title": "Richmond",                           "latitude": 43.009345, "longitude": -78.785852],
            ["title": "Red Jacket",                           "latitude": 43.009112, "longitude": -78.787042],
            ["title": "Ellicott M",                           "latitude": 43.009588, "longitude": -78.785995],
            ["title": "Furnas C",                           "latitude": 43.001955, "longitude": -78.786786],
            ["title": "Flint",                           "latitude": 42.999869, "longitude": -78.788933],
            ["title": "Fargo",                           "latitude": 43.007175, "longitude": -78.785438],
            ["title": "Student Union C",                           "latitude": 43.001394, "longitude": -78.785598],

            ]
            
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
    }
    
    func ceateDiningPoints(){
        
        let locations = [
            ["title": "Teddy's",                           "latitude": 43.00248, "longitude": -78.794472],
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
            ["title": "Lockwood Memorial Library",                         "latitude": 43.00025286178912, "longitude": -78.78602757819535],
            ["title": "Student Union",                         "latitude": 43.00116440108123, "longitude": -78.78614704127043],
            ["title": "Center for the Arts",                         "latitude": 43.00094654481062, "longitude": -78.78287575151788],
            ["title": "Morris Sports Performance Center",                         "latitude": 42.99979165944014, "longitude": -78.77900287503519],
            ["title": "UB Stadium",                         "latitude": 42.99896794670038, "longitude": -78.77749998430836],
            ["title": "Murchie Family Fieldhouse",                         "latitude": 43.000445, "longitude": -78.777548],
            ["title": "Bissell Hall",                         "latitude": 42.99852701596522, "longitude": -78.78071863279813],
            ["title": "Slee Hall",                         "latitude": 43.00042328004822, "longitude": -78.78398765182203],
            ["title": "NC Childcare Center",                         "latitude": 43.00232107052543, "longitude": -78.7798510839301],
            ["title": "Capen Hall",                         "latitude": 43.00087988480986, "longitude": -78.78956773229439],
            ["title": "Talbert Hall",                         "latitude": 43.00068631540694, "longitude": -78.7903774787054],
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
            
            ["title": "Alumni A",   "subtitle": "Arts, Athletics or Events Lot",       "latitude": 43.000716, "longitude": -78.780223],
            ["title": "Alumni C",  "subtitle": "Arts, Athletics or Events Lot",        "latitude": 43.001909, "longitude": -78.779976],
            ["title": "Arena",   "subtitle": "Arts, Athletics or Events Lot",          "latitude": 43.000857, "longitude": -78.779418],
            ["title": "Baird A",   "subtitle": "Arts, Athletics or Events Lot",        "latitude": 42.998558, "longitude": -78.784504],
            ["title": "Baird B",   "subtitle": "Arts, Athletics or Events Lot",        "latitude": 42.998401, "longitude": -78.7871],
            ["title": "Jacobs A",   "subtitle": "Arts, Athletics or Events Lot",       "latitude": 42.998511, "longitude": -78.788302],
            ["title": "Jacobs B",   "subtitle": "Arts, Athletics or Events Lot",       "latitude": 42.998401, "longitude": -78.7871],
            ["title": "Jacobs C",   "subtitle": "Arts, Athletics or Events Lot",       "latitude": 42.998574, "longitude": -78.786113],
            ["title": "Lake La Salle",   "subtitle": "Arts, Athletics or Events Lot",  "latitude": 43.001328, "longitude": -78.781049],
            ["title": "Baird A",   "subtitle": "Arts, Athletics or Events Lot",        "latitude": 42.998558, "longitude": -78.784504],
            ["title": "Slee A",   "subtitle": "Arts, Athletics or Events Lot",         "latitude": 42.99848, "longitude": -78.783517],
            ["title": "Slee B",   "subtitle": "Arts, Athletics or Events Lot",         "latitude": 42.999374, "longitude": -78.783474],
            ["title": "Special Events",   "subtitle": "Arts, Athletics or Events Lot", "latitude": 42.997648, "longitude": -78.784418],
            
            
            
            ["title": "Furnas",   "subtitle": "Faculty/Staff Lot",         "latitude": 43.00245, "longitude": -78.786328],
            ["title": "Governors A",   "subtitle": "Faculty/Staff Lot",    "latitude": 43.00234, "longitude": -78.790877],
            ["title": "Hochstetter A",   "subtitle": "Faculty/Staff Lot",  "latitude": 42.998809, "longitude": -78.791585],
            ["title": "Jacobs A",   "subtitle": "Faculty/Staff Lot",       "latitude": 42.998511, "longitude": -78.788302],

            
            ["title": "Cooke A",   "subtitle": "Parking by Permit",        "latitude": 42.999437, "longitude": -78.793216],
            ["title": "Cooke B",   "subtitle": "Parking by Permit",        "latitude": 42.998715, "longitude": -78.793237],
            ["title": "Crofts",   "subtitle": "Parking by Permit",         "latitude": 42.994807, "longitude": -78.797078],
            ["title": "Fronczak",   "subtitle": "Parking by Permit",       "latitude": 43.002425, "longitude": -78.791424],
            ["title": "Hochstetter B",   "subtitle": "Parking by Permit",  "latitude": 42.99859, "longitude": -78.790212],
            ["title": "Jarvis A",   "subtitle": "Parking by Permit",       "latitude": 43.003721, "longitude": -78.788517],
            ["title": "Jarvis B",   "subtitle": "Parking by Permit",       "latitude": 43.003972, "longitude": -78.786929],
            ["title": "Ketter",   "subtitle": "Parking by Permit",         "latitude": 43.002466, "longitude": -78.788838],
            ["title": "Park Hall",   "subtitle": "Parking by Permit",      "latitude": 42.999657, "longitude": -78.788688],

            
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

