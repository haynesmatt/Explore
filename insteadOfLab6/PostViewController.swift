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
    @IBOutlet weak var saveButton: UIButton!
    
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
        
        setSaved()
    }
    
    @IBAction func onSave(_ sender: Any) {
        guard let user = PFUser.current() else { return }
        let relation = user.relation(forKey: "likes")
        let query = relation.query()
        
        query.whereKey("objectId", equalTo: post.objectId)
        
        if let object = try? query.getFirstObject() {
            saveButton.setTitle("Save", for: UIControl.State.normal)
            saveButton.backgroundColor = UIColor.systemGray4
            saveButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            
            relation.remove(post)
            user.saveInBackground { (succeeded, error) in
                if (succeeded) {
                    print("This post has been added to the user's likes relation.")
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
        }
            
            
        } else {
            saveButton.backgroundColor = UIColor.gray
            saveButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            saveButton.layer.cornerRadius = 30
            saveButton.setTitle("Saved", for: UIControl.State.normal)
            saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            // saveButton.font = UIFont.boldSystemFont(ofSize: 16.0)
            
            relation.add(post)
            user.saveInBackground { (succeeded, error) in
                if (succeeded) {
                    print("This post has been removed from the user's likes relation.")
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
        }
        
        relation.add(post)
        relation.remove(post)
        user.saveInBackground { (succeeded, error) in
            if (succeeded) {
                print("This post has been added to the user's likes relation.")
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        
        
    }
    }
    
    func setSaved() {
        guard let user = PFUser.current() else { return }
        let relation = user.relation(forKey: "likes")
        let query = relation.query()
        
        query.whereKey("objectId", equalTo: post.objectId)
        
        if let object = try? query.getFirstObject() {
            saveButton.backgroundColor = UIColor.gray
            saveButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            saveButton.layer.cornerRadius = 30
            saveButton.setTitle("Saved", for: UIControl.State.normal)
            saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            // saveButton.font = UIFont.boldSystemFont(ofSize: 16.0)
        } else {
            saveButton.setTitle("Save", for: UIControl.State.normal)
        }
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
