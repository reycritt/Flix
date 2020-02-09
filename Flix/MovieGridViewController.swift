//
//  MovieGridViewController.swift
//  Flix
//
//  Created by cory on 2/9/20.
//  Copyright © 2020 cory. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var movies = [[String: Any]]()
    @IBOutlet var collectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5//Spacing of lines horizontal between images/cells
        layout.minimumInteritemSpacing = 5;//Spacing of vertical lines between images/cells
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3//Changes based on phone!!!!!
        layout.itemSize = CGSize(width: width, height: width * 2 / 3)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies = dataDictionary["results"] as! [[String: Any]]
            self.collectionView.reloadData()
            
            //print(self.movies)
            }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]//Collection does not have "row", but "item"
        
        let baseURL = "https://image.tmdb.org/t/p/w185"//Under Images in movie database
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)//Combines baseURL with posterPath to pull and create image from website of database
        cell.posterView.af_setImage(withURL: posterURL!)
        
        return cell
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
