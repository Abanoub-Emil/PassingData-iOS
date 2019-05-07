//
//  TableViewModel.swift
//  AlamofireAndNavigation
//
//  Created by Mai Hassan on 2/10/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieTableViewModel {
    
    var allMovies = [Movie]()
    let URL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=23cca2d1f3e44625a0e74b4f7435b5ea"
    
    func getAllMovies(success:@escaping ([Movie]) -> Void, failure:@escaping (Error) -> Void) {
        AFWrapper.requestGETURL(URL, success: { (json) in
            let movies = JSON(json["results"]).arrayValue
            for movie in movies {
                let myMovie = Movie()
                
                myMovie.title = movie["title"].stringValue
                myMovie.image += movie["poster_path"].stringValue
                print(movie["title"].stringValue)
                self.allMovies.append(myMovie)
            }
            success(self.allMovies)
        }) { (Error) in
            failure(Error)
        }
    }
    
    func presentDetailsView(movie: Movie) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.movie = movie
        return vc
    }
    
}
