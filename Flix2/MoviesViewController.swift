//
//  MoviesViewController.swift
//  Flix2
//
//  Created by Olivia Gregory on 6/15/16.
//  Copyright © 2016 Olivia Gregory. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var listViewButton: UIButton!
    @IBOutlet weak var gridViewButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topRatedView: UIView!
    @IBOutlet weak var movieSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var moviesGridView: UICollectionView!
    @IBOutlet weak var moviesTableView: UITableView!
    var movies: [NSDictionary]?
    var topRated: [NSDictionary]?
    var filteredData: [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesGridView.hidden = true
        listViewButton.hidden = true
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        moviesTableView.insertSubview(refreshControl, atIndex: 0)
        moviesGridView.insertSubview(refreshControl, atIndex: 0)
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        moviesGridView.dataSource = self
        moviesGridView.delegate = self
        
        searchBar.delegate = self
        filteredData = movies
        
        var movieChoice = movieSegmentedControl.selectedSegmentIndex
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        var url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        if (movieChoice == 0) {
            url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        }
        if (movieChoice == 1) {
            url = NSURL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")!
        }
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
//       
//        let ratingsurl = NSURL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")
//        let ratingsrequest = NSURLRequest(
//            URL: ratingsurl!,
//            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
//            timeoutInterval: 10)
//        let ratingssession = NSURLSession(
//            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
//            delegate: nil,
//            delegateQueue: NSOperationQueue.mainQueue()
//        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
                                                                     completionHandler: { (dataOrNil, response, error) in
                                                                        
                                                                        MBProgressHUD.hideHUDForView(self.view, animated: true)
                                                                        
                                                                        if let data = dataOrNil {
                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                                                data, options:[]) as? NSDictionary {
                                                                               // print("response: \(responseDictionary)")
                                                                                
                                                                               self.movies = responseDictionary["results"] as! [NSDictionary]
                                                                                
                                                                               
                                                                                self.filteredData = self.movies
                                                                                self.moviesTableView.reloadData()
                                                                                
                                                                                self.moviesGridView.reloadData()
                                                                                
                                                                            }
                                                                            //print("Mode on Open: " + (String(self.movieSegmentedControl.selectedSegmentIndex)))
                                                                        }
        })
        
//        let ratingstask: NSURLSessionDataTask = ratingssession.dataTaskWithRequest(ratingsrequest,
//                                                                     completionHandler: { (dataOrNil, response, error) in
//                                                                        
//                                                                        
//                                                                        if let data = dataOrNil {
//                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
//                                                                                data, options:[]) as? NSDictionary {
//                                                                                print("response: \(responseDictionary)")
//                                                                                
//                                                                                self.topRated = responseDictionary["results"] as! [NSDictionary]
//                                                                                self.moviesTableView.reloadData()
//                                                                                self.moviesGridView.reloadData()
//                                                                                
//                                                                            }
//                                                                        }
//        })
//        let defaults = NSUserDefaults.standardUserDefaults()
//        //defaults.setIn(0.2, forKey: "default_tip_percentage")
//        defaults.setInteger(movieSegmentedControl.selectedSegmentIndex, forKey: "selectedMode")
//            defaults.synchronize()
        
        task.resume()
    }
    
    
    
    @IBAction func modeChanged(sender: AnyObject) {
        let refreshControl = UIRefreshControl()
        refreshControlAction(refreshControl)
  
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(movieSegmentedControl.selectedSegmentIndex, forKey: "selectedMode")
        defaults.synchronize()
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        moviesTableView.hidden = true
        gridViewButton.hidden = true
        moviesGridView.hidden = false
        listViewButton.hidden = false
    }
    
    @IBAction func listButtonPressed(sender: AnyObject) {
        moviesTableView.hidden = false
        gridViewButton.hidden = false
        moviesGridView.hidden = true
        listViewButton.hidden = true
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let modeChoice = defaults.integerForKey("selectedMode")
        //let modeChoice = defaults.doubleForKey("selectedMode")
        
        var movieChoice = movieSegmentedControl.selectedSegmentIndex
        ///var movieChoice = modeChoice
        //print ("MovieChoice: " + String(movieChoice))
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        var url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        if (movieChoice == 0) {
        //if (modeChoice == 0) {
            url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        }
        if (movieChoice == 1) {
        //if (modeChoice == 1) {
            url = NSURL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")!
        }
        
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
                                                                     completionHandler: { (dataOrNil, response, error) in
                                                                        
                                                                        
                                                                        
                                                                        if let data = dataOrNil {
                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                                                data, options:[]) as? NSDictionary {
                                                                              //  print("response: \(responseDictionary)")
                                                                                
                                                                                self.movies = responseDictionary["results"] as! [NSDictionary]
                                                                                self.filteredData = self.movies
                                                                                self.moviesTableView.reloadData()
                                                                                
                                                                                self.moviesGridView.reloadData()
                                                                            }
                                                                        }
                                                                        refreshControl.endRefreshing()
                                                                        
        })
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = movies
        } else {
            filteredData = movies!.filter({(dataItem: NSDictionary) -> Bool in
                if (dataItem["title"] as! String).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        moviesTableView.reloadData()
        moviesGridView.reloadData()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if let movies = movies {
        if let filteredData = filteredData {
        //    return movies.count
            return filteredData.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        //let movie = movies![indexPath.row]
        let movie = filteredData![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseURL + posterPath)
        //cell.textLabel?.text = (filteredData![indexPath.row].valueForKeyPath("title") as! String)
        
        let imageRequest = NSURLRequest(URL: NSURL(string: baseURL + posterPath)!)
        
        cell.posterView.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    cell.posterView.alpha = 0.0
                    cell.posterView.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        cell.posterView.alpha = 1.0
                    })
                } else {
                    cell.posterView.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
        
        cell.posterView.setImageWithURL(imageURL!)
        
        
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterView.setImageWithURL(imageURL!)
        cell.backgroundImage.setImageWithURL(imageURL!)
        
        
//        if (topRated!.contains(movie)) {
//            cell.topRatedView.hidden = false;
//        }
//        else {
            cell.topRatedView.hidden = true
//        }
//        
        
        //print ("row \(indexPath.row)")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let filteredData = filteredData {
            return filteredData.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieGridCell", forIndexPath: indexPath) as! MovieCollectionViewCell
        //let movie = movies![indexPath.row]
        let movie = filteredData![indexPath.row]
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseURL + posterPath)
        
        
        let imageRequest = NSURLRequest(URL: NSURL(string: baseURL + posterPath)!)
        
        cell.posterImage.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    cell.posterImage.alpha = 0.0
                    cell.posterImage.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        cell.posterImage.alpha = 1.0
                    })
                } else {
                    cell.posterImage.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
        
        cell.posterImage.setImageWithURL(imageURL!)
        
        //print ("row \(indexPath.row)")
        return cell

    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var indexPath: NSIndexPath
        var vc = segue.destinationViewController as! MovieDetailsViewController
        if moviesGridView.hidden == true {
            indexPath = moviesTableView.indexPathForCell(sender as! UITableViewCell)!
        }
        else {
            indexPath = moviesGridView.indexPathForCell(sender as! UICollectionViewCell)!
        }
        
        vc.posterURL = filteredData![indexPath.row].valueForKeyPath("poster_path") as! String
        vc.overviewText = filteredData![indexPath.row].valueForKeyPath("overview") as! String
        vc.titleText = filteredData![indexPath.row].valueForKeyPath("title") as! String
        let rating = (filteredData![indexPath.row].valueForKeyPath("vote_average"))?.stringValue
        vc.ratingText = rating!
    }
}




