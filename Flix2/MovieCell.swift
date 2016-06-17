//
//  MovieCell.swift
//  Flix2
//
//  Created by Olivia Gregory on 6/15/16.
//  Copyright © 2016 Olivia Gregory. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var topRatedView: UIView!
    
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var star2: UIImageView!
    
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    //@IBOutlet weak var moreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
