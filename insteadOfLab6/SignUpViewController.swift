//
//  SignUpViewController.swift
//  insteadOfLab6
//
//  Created by Amit Tzadok on 4/27/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        )
        
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        )
        
        addBottomBorder(box: usernameField)
        addBottomBorder(box: passwordField)

        // Do any additional setup after loading the view.
    }
    
    func addBottomBorder(box: UITextField){
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: box.frame.size.height - 1, width: box.frame.size.width, height: 1)
            bottomLine.backgroundColor = UIColor.white.cgColor
        box.borderStyle = .none
        box.layer.addSublayer(bottomLine)
        }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground{(success, error) in
            if success {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
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
