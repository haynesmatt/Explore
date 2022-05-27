//
//  FeedViewController.swift
//  insteadOfLab6
//
//  Created by Amit Tzadok on 4/13/22.
//

import UIKit
import AlamofireImage
import Parse

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarPlaceholder: UIView!
    @IBOutlet weak var categoryControl: UISegmentedControl!
    
    let data = ["Davis Hall", "C3", "Lee Loop", "Anchor Bar", "Downtown Buffalo", "Watkins Glen State Park", "Niagara Falls", "Baird Point", "One World Cafe", "Baird Point", "Flowers @ Ellicott", "Letchworth State Park", "Whirlpool State Park", "Lake La Salle Water Fall", "Flower Garden by Davis Hall", "Woodlawn Beach State Park", "Ellicott Creek Hiking Trail"]
    
    var posts = [PFObject]()
    var count: Int = 1

    var filteredData: [String]!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        categoryControl.backgroundColor = .clear
        categoryControl.tintColor = .clear
        let backgroundImage = UIImage(named: "notselected.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        categoryControl.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        let backgroundImage2 = UIImage(named: "selected.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        categoryControl.setBackgroundImage(backgroundImage2, for: .selected, barMetrics: .default)
        categoryControl.removeBorders()
        categoryControl.layer.cornerRadius = 25.0
        categoryControl.layer.borderColor = UIColor.white.cgColor
        categoryControl.layer.borderWidth = 1.0
        categoryControl.layer.masksToBounds = true
        scroll.addSubview(categoryControl)
        scroll.contentSize = CGSize(width: categoryControl.frame.size.width, height: categoryControl.frame.size.height + 5) //change accordingly
        view.addSubview(scroll)
        
        filteredData = data
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBarPlaceholder.addSubview(searchController.searchBar)
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            viewDidAppear(true)
            collectionView.reloadData()
        }
    }
    
    @IBAction func changeCategory(_ sender: Any) {
        viewDidAppear(true)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size: CGFloat = (cell.frame.size.width - space) / 2.0
            return CGSize(width: size, height: size)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let categoryindex = self.categoryControl.selectedSegmentIndex
        let category = ["All","Food", "Study", "Nature", "Leisure", "Views", "Sunsets", "Housing", "Shopping"]
        
        let query2 = PFQuery(className:"Posts")
        let query1 = query2.whereKey("title", contains: searchController.searchBar.text)
        if categoryindex != 0 {
            let query = query1.whereKey("category", contains: category[categoryindex])
            query.includeKey("author")
            query.limit = 20
            query.order(byDescending: "createdAt")
            
            query.findObjectsInBackground { (posts, error) in
                if posts != nil {
                    self.posts = posts!
                    self.collectionView.reloadData()
                }
            }
        } else {
            let query = query1
            query.includeKey("author")
            query.limit = 20
            query.order(byDescending: "createdAt")
            
            query.findObjectsInBackground { (posts, error) in
                if posts != nil {
                    self.posts = posts!
                    self.collectionView.reloadData()
                }
            }
        }
        self.collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell

        let post = posts[indexPath.row]
        
        cell.titleLabel.text = post["title"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        let filter = AspectScaledToFillSizeFilter(size: cell.photoView.frame.size)
        
        cell.photoView.af_setImage(withURL: url, filter: filter)
        cell.photoView.layer.cornerRadius = 20
        
        if count <= posts.count {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = cell.photoView.frame
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.locations = [0.9, 1.2]
            cell.photoView.layer.insertSublayer(gradient, at: 0)
            count += 1
        }
        return cell
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
        let post = posts[indexPath.row]
        
        // pass post to postViewController
        let postViewController = segue.destination as! PostViewController
        postViewController.post = post
        }
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard (name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let
        delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window? .rootViewController = loginViewController
    }

}

extension UISegmentedControl {
  func removeBorders() {
    setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
  }
  // create a 1x1 image with this color
  private func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor);
    context!.fill(rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image!
  }
}
