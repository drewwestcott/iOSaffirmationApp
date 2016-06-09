//
//  AffirmationCell.swift
//  Affirmation
//
//  Created by Drew Westcott on 01/04/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit

class AffirmationCell: UITableViewCell {
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var mainLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
