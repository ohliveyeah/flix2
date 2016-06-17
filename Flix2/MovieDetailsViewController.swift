//
//  MovieDetailsViewController.swift
//  Flix2
//
//  Created by Olivia Gregory on 6/16/16.
//  Copyright © 2016 Olivia Gregory. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var infoButton: UIButton!
    var posterURL : String = ""
    var overviewText: String = ""
    var titleText: String? = ""
    var ratingText: String = ""
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    @IBOutlet weak var posterView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterURL)
        posterView.setImageWithURL(imageURL!)
        
        infoButton.addTarget(self, action: #selector(infoButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        overviewLabel.text = overviewText
        titleLabel.text = titleText
        ratingLabel.text =  "Rating: " + ratingText + "/10"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openWebsite(){
        if let titleText = titleText {
            print(titleText)
            print("http://www.imdb.com/find?ref_=nv_sr_fn&q= \(titleText) &s=all")
            let urltitleText = titleText.stringByReplacingOccurrencesOfString(" ", withString: "+")
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.imdb.com/find?ref_=nv_sr_fn&q=\(urltitleText)&s=all")!)
        }
    }
    
    @IBAction func infoButtonPressed(sender: AnyObject) {
        openWebsite()
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
