//
//  SignUpViewController.swift
//  insteadOfLab6
//
//  Created by Amit Tzadok on 4/27/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        usernameField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        addBottomBorder(box: usernameField)
        addBottomBorder(box: passwordField)

        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }
    
    func addBottomBorder(box: UITextField){
            let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: box.frame.size.height - 1, width: box.frame.size.width, height: 1)
            bottomLine.backgroundColor = UIColor(hue: 0.5833, saturation: 1, brightness: 0.73, alpha: 1.0).cgColor
        box.borderStyle = .none
        box.layer.addSublayer(bottomLine)
        }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground{ [self](success, error) in
            if success {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
            } else{
                errorLabel.text = error?.localizedDescription
                errorLabel.textColor = .systemRed
                errorLabel.isHidden = false
                errorLabel.shake()
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
           textField.resignFirstResponder()
           passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            dismissKeyboard()
        }
        

       return true
      }
    

}
