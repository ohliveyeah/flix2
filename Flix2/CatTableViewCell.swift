//
//  CatTableViewCell.swift
//  Flix2
//
//  Created by Olivia Gregory on 6/17/16.
//  Copyright © 2016 Olivia Gregory. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
