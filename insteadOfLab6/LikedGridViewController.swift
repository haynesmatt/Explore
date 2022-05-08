//
//  LikedGridViewController.swift
//  insteadOfLab6
//
//  Created by Matt Haynes on 5/7/22.
//

import UIKit
import AlamofireImage
import Parse

class LikedGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var likes = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let user = PFUser.current() else { return }
        let relation = user.relation(forKey: "likes")
        let query = relation.query()
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (likes, error) in
            if error == nil {
                self.likes = likes!
                self.collectionView.reloadData()
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikedGridCell", for: indexPath) as! LikedGridCell
        
        let post = likes[indexPath.row]
        
        // cell.titleLabel.text = post["title"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        let filter = AspectScaledToFillSizeFilter(size: cell.photoView.frame.size)
        
        cell.photoView.af_setImage(withURL: url, filter: filter)
        // cell.photoView.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // find post
        if segue.identifier == "post" {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let post = likes[indexPath.row]
        
        // pass post to postViewController
        let postViewController = segue.destination as! PostViewController
        postViewController.post = post
        }
    }
    

}
