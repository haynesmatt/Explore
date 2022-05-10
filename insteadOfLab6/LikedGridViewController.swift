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
    var count: Int = 1
    
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
        
        if count <= likes.count {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = cell.photoView.frame
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.locations = [0.8, 1.1]
            cell.photoView.layer.insertSublayer(gradient, at: 0)
            count += 1
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        var totalHeight: CGFloat = (self.view.frame.width / 3)
        var totalWidth: CGFloat = (self.view.frame.width / 3)

        print(totalWidth) // this prints 106.666666667

        return CGSize(width: totalWidth, height: totalHeight)
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
