//
//  ServicesViewController.swift
//  insteadOfLab6
//
//  Created by Robert Reyes-Enamorado on 4/7/22.
//

import UIKit

class ServicesViewController: UIViewController {

    var buttonIndex = 0
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loaded Services View Controller")

        // Do any additional setup after loading the view.
    }
    

    @IBAction func printerButtonPressed(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! ViewController
        controller.index = 1
        
        self.show(controller, sender: (Any).self)
    }
       
    @IBAction func parkingButtonPressed(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! ViewController
        controller.index = 2
        
        self.show(controller, sender: (Any).self)
    }
    
    
    @IBAction func DiningButtonPressed(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! ViewController
        controller.index = 5
        
        self.show(controller, sender: (Any).self)
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
