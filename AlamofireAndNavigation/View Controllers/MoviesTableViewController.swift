//
//  MoviesTableViewController.swift
//  AlamofireAndNavigation
//
//  Created by Mai Hassan on 2/10/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesTableViewController: UITableViewController, MovieDelegate {
    
    var tableViewModel = MovieTableViewModel()
    static let notificationName = Notification.Name("myNotificationName")
    var allMovies = [Movie]()
    var currentRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)),
                                               name: MoviesTableViewController.notificationName,
                                               object: nil)
        
        tableViewModel.getAllMovies(success: { (allMovies) in
            self.allMovies = allMovies
            self.tableView.reloadData()
        }, failure: { (Error) in
            print(Error)
        })
        print(allMovies.count)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allMovies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = allMovies[indexPath.row].title
        cell.imageView?.sd_setImage(with: URL(string: allMovies[indexPath.row].image), placeholderImage: UIImage(named: "record1"))
        
        return cell
    }
    
    //        MARK: - First Way to send data Forward
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        let vc = tableViewModel.presentDetailsView(movie: allMovies[indexPath.row])
        //        present(vc, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    // MARK: - Navigation
    // MARK: - Second Way to send data Forward
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailsViewController
        {
            let vc = segue.destination as? DetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                vc?.movie = allMovies[selectedRow]
                
                // MARK: - First Way Backward using direct reference
                //                vc?.movieViewController = self
                
                // MARK: - Second Way Backward using delegate
                //                vc?.delegate = self
                
                
                // MARK: - Third Way Backward using closure
//                vc!.completionHandler = { [weak self] text in
//                    self?.allMovies.first?.title = text
//                    self?.tableView.reloadData()
//                }
            }
        }
    }
    
    
    func onBackPressed (title: String) {
        allMovies.first?.title = title
        tableView.reloadData()
        print(title)
    }
    
    // MARK: - Fourth Way Backward using Notification Center
    @objc func onNotification(notification: Notification){
        allMovies.first?.title = notification.userInfo![0] as? String
        tableView.reloadData()
    }
    
}
