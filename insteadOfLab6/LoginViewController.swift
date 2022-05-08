//
//  LoginViewController.swift
//  insteadOfLab6
//
//  Created by Amit Tzadok on 4/13/22.
//

import UIKit
import Parse

extension UIView {
    func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }

        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)

        propertyAnimator.startAnimation()
    }
}
class LoginViewController: UIViewController {
    
    @IBOutlet weak var frame: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(logo)

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
        bottomLine.backgroundColor = UIColor(hue: 0.5833, saturation: 1, brightness: 0.73, alpha: 1.0).cgColor
        box.borderStyle = .none
        box.layer.addSublayer(bottomLine)
        }
    
    @IBAction func onLogIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password){ [self]
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                errorMessageLabel.isHidden = true

            } else{
                errorMessageLabel.text = "Invalid username or password"
                errorMessageLabel.textColor = .systemRed
                errorMessageLabel.isHidden = false
                errorMessageLabel.shake()
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
