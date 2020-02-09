//
//  MoviesViewController.swift
//  Flix
//
//  Created by cory on 2/2/20.
//  Copyright © 2020 cory. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String: Any]]()//Creates a dictionary with the data type (here is String) and the value (here is Any, for any data type)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies = dataDictionary["results"] as! [[String: Any]]//Sets movies as all values of dictionary type String of Any values under the "results" hash of the movie API
            self.tableView.reloadData()//Upon loading, information is held but not displayed. Reloading the table view allows movies.count to display and use its values (calls all functions in table view)
            print(dataDictionary)//prints all values within the API

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//Asking for number of rows
        return movies.count//Returns how many rows in the list/table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//The cell to be displayed; can be used as a template for multiple rows
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell//Saves space by recycling existing, unused cells; "as!" casts to MovieCell, allowing the UI file to be used
        
        let movie = movies[indexPath.row]//A movie will be set as a movie from movies dictionary based on the row number
        let title = movie["title"] as! String//Casts the dictionary key "title" as a String, calling the key's value into a String
        let synopsis = movie["overview"] as! String
        cell.titleLabel!.text = title//Displays the row number, represented by indexPath.row
        cell.synopsisLabel!.text = synopsis
        
        let baseURL = "https://image.tmdb.org/t/p/w185"//Under Images in movie database
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)//Combines baseURL with posterPath to pull and create image from website of database
        cell.posterView.af_setImage(withURL: posterURL!)
        
        
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading up details")
        
        //Find selected movie
        let cell = sender as! UITableViewCell//The sender is what brings data over from a specific view, set default as "Any?" is func declaration
        let indexPath = tableView.indexPath(for: cell)!//Defines the location of an item inside a tableview
        let movie = movies[indexPath.row]//The defines a movie as one of the movies in the tableview based on its value from indexPath
        
        //Pass movie to views
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie//Helps pass the data of the movie selected into "movie"
        
        //tableView.deselectRow(at: indexPath, animated: true)//Upon return from the push navigation, deselects the last cell; I prefer leaving it selected as it marks what was last clicked
    }

}
/*
 For anything related to UI interface, such as the view controllers and table cells, create a Coca file. Swift is for programming, and SwiftUI is for views.
 Cells will go in there own file since they can be repeated. The table goes into the view controller.
 */
/*
 Push navigation - slides screen from left to right, with back option on top
 Tab bar - a menu on the screen to switch view controllers
 */
