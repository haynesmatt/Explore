//
//  LoginViewController.swift
//  insteadOfLab6
//
//  Created by Amit Tzadok on 4/13/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Do any additional setup after loading the view.
        
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func addBottomBorder(box: UITextField){
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: box.frame.size.height - 1, width: box.frame.size.width, height: 1)
            bottomLine.backgroundColor = UIColor.white.cgColor
        box.borderStyle = .none
        box.layer.addSublayer(bottomLine)
        }
    
    @IBAction func onLogIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password){
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print("Error: \(error?.localizedDescription)")
            }
            
        }
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
