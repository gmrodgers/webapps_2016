//
//  CardTableViewCell.swift
//  Cardspark
//
//  Created by Leanne Lyons on 28/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

  @IBOutlet weak var cardLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
