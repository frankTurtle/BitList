//
//  AddToDoTableViewCell.swift
//  BitList
//
//  Created by Mr. Nobel on 6/11/16.
//  Copyright © 2016 Mr. Nobel. All rights reserved.
//

import UIKit

class AddToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var addToDoTextField: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteButton.backgroundColor = UIColor.orangeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteButtonPressed(sender: UIButton) {
        if( addToDoTextField.isFirstResponder() ){ //.......... if the keyboard is shown by user tapping the TF
            favorited = !favorited //.......................... update favorited
            
            favoriteButton.backgroundColor = ( favorited ) ? UIColor.blueColor() : UIColor.orangeColor()
        }
    }
}
