//
//  SuperheroViewController.swift
//  Flix
//
//  Created by cory on 2/9/20.
//  Copyright © 2020 cory. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController {
    
    var movie: [String: Any]!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185"//Under Images in movie database
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)//Combines baseURL with posterPath to pull and create image from website of database
        posterView.af_setImage(withURL: posterURL!)
        
        /*
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseURL + backdropPath)//To specify a specific backdrop size, change "baseURL" in "backdropURL" with the link to the image database with a width included in the API
        backdropView.af_setImage(withURL: backdropURL!)
         *///This would be if I wanted to have 2 posters: a smaller poster, and a backdrop which covers a larger area
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
//NOTE: TRY THE VIDEO THINGY
