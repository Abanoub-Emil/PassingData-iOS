//
//  ViewController.swift
//  AlamofireAndNavigation
//
//  Created by Mai Hassan on 2/10/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var movie = Movie()
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        movieTitle.text = movie.title!
        movieImage.sd_setImage(with: URL(string: movie.image), placeholderImage: UIImage(named: "record1"))
    }
    
    //        MARK: - First Way
//    var movieViewController: MoviesTableViewController?
    
    //        MARK: - Second Way
//    var delegate: MovieDelegate?
    
    // Mark: - Third Way
//    var completionHandler:((String) -> Void)?

    
    @IBAction func back(_ sender: UIButton) {
        //        MARK: - First Way
//        movieViewController?.onBackPressed(title: textField.text!)
        
        //        MARK: - Second Way
//        delegate?.onBackPressed(title: textField.text!)
        
        // MARK: - Third Way using closures
//        completionHandler!(textField.text!)
        
        // MARK: - Fourth Way using Notification Center
        NotificationCenter.default.post(name: MoviesTableViewController.notificationName,
                                        object: nil,
                                        userInfo:[0: textField.text!, 1: "champion"])
        
        dismiss(animated: true, completion: nil)
    }
}

protocol MovieDelegate
{
    func onBackPressed (title: String) 
}
