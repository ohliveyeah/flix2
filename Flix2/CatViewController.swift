//
//  CatViewController.swift
//  Flix2
//
//  Created by Olivia Gregory on 6/17/16.
//  Copyright © 2016 Olivia Gregory. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {
    
    @IBOutlet weak var catTableView: UITableView!
    var categories: [String] = [
        "Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family","Fantasy","Foreign","History",
        "Horror",
        "Music",
        "Mystery",
        "Romance",
        "Science Ficton",
        "TV Movie",
        "Thriller",
        "War",
        "Western"
    ]
    var idString: String = String(16)
    
    let categoryMap: [String:Int] = [
        "Action" : 28,
        "Adventure" : 12,
        "Animation" : 16,
        "Comedy" : 35,
        "Crime" : 80,
        "Documentary" : 99,
        "Drama" : 18,
        "Family" : 10751,
        "Fantasy" : 14,
        "Foreign" : 10769,
        "History" : 36,
        "Horror" : 27,
        "Music" : 10402,
        "Mystery" : 9648,
        "Romance" : 10749,
        "Science Ficton" : 878,
        "TV Movie" : 10770,
        "Thriller" : 53,
        "War" : 10752,
        "Western" : 37
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        catTableView.dataSource = self
//        catTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CatTableViewCell
        cell.categoryLabel.text = "row \(indexPath.row)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
