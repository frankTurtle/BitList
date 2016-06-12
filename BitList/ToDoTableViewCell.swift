//
//  ToDoTableViewCell.swift
//  BitList
//
//  Created by Mr. Nobel on 6/11/16.
//  Copyright © 2016 Mr. Nobel. All rights reserved.
//

import UIKit

protocol ToDoTableViewCellDelegate {
    func completeToDo( indexPath: NSIndexPath )
    func favoriteToDo( indexPath: NSIndexPath )
}

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var indexPath: NSIndexPath!
    
    var delegate: ToDoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeButtonPressed(sender: UIButton) {
        delegate?.completeToDo( indexPath )
    }
    
    @IBAction func favoriteButtonPressed(sender: UIButton) {
        delegate?.favoriteToDo( indexPath )
    }
    
    // Method to hide elements if editing
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated) //....... call superclass implementation
        
        if( editing ){
            dateLabel.hidden = true
            completeButton.hidden = true
            favoriteButton.hidden = true
        }
        else{
            dateLabel.hidden = false
            completeButton.hidden = false
            favoriteButton.hidden = false
        }
    }
}
