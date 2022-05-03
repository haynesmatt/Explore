//
//  PostViewController.swift
//  insteadOfLab6
//
//  Created by Matt Haynes on 4/16/22.
//

import UIKit
import AlamofireImage
import Parse

class PostViewController: UIViewController {
    
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
