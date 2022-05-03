//
//  PostViewController.swift
//  insteadOfLab6
//
//  Created by Matt Haynes on 4/16/22.
//

import UIKit
import AlamofireImage
import Parse
import MapKit

class PostViewController: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var postView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = post["title"] as? String
        descriptionLabel.text = post["description"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let filter = AspectScaledToFillSizeFilter(size: postView.frame.size)
        postView.af_setImage(withURL: url, filter: filter)
    }
    
    @IBAction func onSave(_ sender: Any) {
    }
    
    @IBAction func onMap(_ sender: Any) {
        let title = post["title"] as? String
        let lat = post["latitude"] as! String
        let long = post["longitude"] as! String
        
        let latCast = Double(lat)
        let longCast = Double(long)

        
        
        let latitude: CLLocationDegrees = latCast!
        let longitude: CLLocationDegrees = longCast!
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        mapItem.openInMaps(launchOptions: options)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
