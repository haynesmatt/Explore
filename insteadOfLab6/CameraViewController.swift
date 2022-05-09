//
//  CameraViewController.swift
//  insteadOfLab6
//
//  Created by Amit Tzadok on 5/2/22.
//

import UIKit
import AlamofireImage
import Parse
import CoreLocation
import CoreLocationUI

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var localeButton: CLLocationButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    let manager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 20
        localeButton.backgroundColor = UIColor(red: 37/255.0, green: 90/255.0, blue: 181/255.0, alpha: 1)
        manager.delegate = self
        
        titleField.delegate = self
        titleField.tag = 0
        
        descriptionField.delegate = self
        
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleField {
           textField.resignFirstResponder()
           descriptionField.becomeFirstResponder()
        } else if textField == descriptionField {
            dismissKeyboard()
        }
       return true
      }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className:"Posts")
        post["author"] = PFUser.current()!
        
        post["title"] = titleField.text!
        post["description"] = descriptionField.text!
        post["latitude"] = latitudeField.text!
        post["longitude"] = longitudeField.text!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data:imageData!)
        
        post["image"] = file
        
        post.saveInBackground{ (success,error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }else{
                print("error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 320, height: 180)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = scaledImage
        imageView.layer.cornerRadius = 20
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {return}
        print(location.coordinate.latitude)                 // coordinates as stored as DOUBLES
        print(location.coordinate.longitude)
        latitudeField.text = String(location.coordinate.latitude)   // updates label with lat
        longitudeField.text = String(location.coordinate.longitude) // updates label with long

            self.manager.stopUpdatingLocation()
    }
    
    @IBAction func pressedLocale(_ sender: Any) {
        manager.startUpdatingLocation()
        print("Location button tapped.")
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
