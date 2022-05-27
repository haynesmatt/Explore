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
    
    @IBOutlet weak var tapLabel: UILabel!

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
    
    @IBOutlet weak var categoryButton: UIButton!
    
    let manager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
    
        localeButton.backgroundColor = UIColor(red: 37/255.0, green: 90/255.0, blue: 181/255.0, alpha: 1)
        
        imageView.layer.cornerRadius = 20
        
        titleField.delegate = self
        descriptionField.delegate = self
        latitudeField.delegate = self
        longitudeField.delegate = self
        
        manager.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UITextField.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        setPopupButton()
    }
    
    func setPopupButton(){
        let optionClosure = {(action : UIAction) in
            print(action.title)}
                                             
        categoryButton.menu = UIMenu(children : [
            UIAction(title : "Other", state: .on, handler: optionClosure),
            UIAction(title : "Food", handler: optionClosure),
            UIAction(title : "Housing", handler: optionClosure),
            UIAction(title : "Leisure", handler: optionClosure),
            UIAction(title : "Nature", handler: optionClosure),
            UIAction(title : "Shopping", handler: optionClosure),
            UIAction(title : "Study", handler: optionClosure),
            UIAction(title : "Views", handler: optionClosure)])
        
        categoryButton.showsMenuAsPrimaryAction = true
        categoryButton.changesSelectionAsPrimaryAction = true
    }
    
   
    var activeTextField = UITextField()

       // Assign the newly active text field to your activeTextField variable
    func textFieldDidBeginEditing(_ textField: UITextField) {

            self.activeTextField = textField
       }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        
        
        if (activeTextField == latitudeField){
            self.view.frame.origin.y = 0
         self.view.frame.origin.y -= 180 // Move view 150 points upward
        }
        else if (activeTextField == longitudeField){
            self.view.frame.origin.y = 0
         self.view.frame.origin.y -= 200 // Move view 150 points upward
        }
    }
    
       @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleField {
           textField.resignFirstResponder()
           descriptionField.becomeFirstResponder()
        } else if textField == descriptionField {
            dismissKeyboard()
        }
        
        else if textField == latitudeField {
            dismissKeyboard()
        }
        
        else if textField == longitudeField {
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
        post["category"] = categoryButton.currentTitle
        
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
        
       // if UIImagePickerController.isSourceTypeAvailable(.camera){
       //     picker.sourceType = .camera
     //   }
      //  else{
            picker.sourceType = .photoLibrary
    //    }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[.editedImage] as! UIImage
       // let size = CGSize(width: 320, height: 180)
       // let scaledImage = image.af_imageScaled(to: size)
       // imageView.image = scaledImage
        imageView.image = image
        imageView.layer.cornerRadius = 20
        tapLabel.isHidden = true
        
        dismiss(animated: true, completion: nil)
    }
    
    
   
    
    @IBAction func tappedLocation(_ sender: Any) {
        print("Location button tapped.")
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {return}
        print(location.coordinate.latitude)                 // coordinates as stored as DOUBLES
        print(location.coordinate.longitude)
        latitudeField.text = String(location.coordinate.latitude)   // updates label with lat
        longitudeField.text = String(location.coordinate.longitude) // updates label with long

            self.manager.stopUpdatingLocation()
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
