//
//  ToDoViewController.swift
//  BitList
//
//  Created by Mr. Nobel on 6/11/16.
//  Copyright © 2016 Mr. Nobel. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var baseArray: [[ToDoModel]] = [] //......... multi-dimensional array full of completed / not tasks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: CGRectZero) //.. setup the footer value - default value is nil
    
        // create some toDo's
        let toDo1 = ToDoModel(title: "Study", favorited: false, completed: false, dueDate: NSDate(), reminder: nil, repeated: nil)
        let toDo2 = ToDoModel(title: "Dinner", favorited: false, completed: false, dueDate: nil, reminder: nil, repeated: nil)
        let toDo3 = ToDoModel(title: "Gym", favorited: false, completed: false, dueDate: nil, reminder: nil, repeated: nil)
        
        baseArray = [[toDo1, toDo2, toDo3], []] //..... add them to the first array as they're not completed yet
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil) //.. tells the notification center when the UIKeyboardWillShowNotification message comes call keyboardWillShow method which we define
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil) //.. essentially the same, but when the keyboard will hide -- we also pass in a parameter to the keyboardWillHide method we write
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editBarButtonItemPressed(sender: UIBarButtonItem) {
        if( sender.title == "Edit" ){
            if( tableView.editing ){
                tableView.setEditing(false, animated: true)
            }
            else {
                tableView.setEditing(true, animated: true)
            }
        }
        else if( sender.title == "Done" ){
            let indexPathOfAddToDoCell = NSIndexPath( forRow: 0, inSection: 0 )
            let addToDoTableViewCell = tableView.cellForRowAtIndexPath( indexPathOfAddToDoCell ) as! AddToDoTableViewCell
            
            if addToDoTableViewCell.addToDoTextField.text != ""{
                let newToDo = ToDoModel( title: addToDoTableViewCell.addToDoTextField.text!, favorited: addToDoTableViewCell.favorited, completed: false, dueDate: nil, reminder: nil, repeated: nil )
                
                baseArray[0].append(newToDo)
                tableView.reloadData()
                
                addToDoTableViewCell.addToDoTextField.text = ""
                addToDoTableViewCell.addToDoTextField.resignFirstResponder()
            }
            else {
                let alert = UIAlertController( title: "Invalid", message: "Enter a title", preferredStyle: UIAlertControllerStyle.Alert )
                
                alert.addAction( UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil) )
                
                presentViewController( alert, animated: true, completion: nil )
            }
        }
    }
    
    // MARK: - Keyboard Notification
    func keyboardWillShow( notification: NSNotification ) {
        navigationItem.rightBarButtonItem?.title = "Done" //.. rename the button
    }
    
    func keyboardWillHide( notificaton: NSNotification ) {
        navigationItem.rightBarButtonItem?.title = "Edit"
    }
}

// MARK: - Extension of our VC for Delegate
extension ToDoViewController: UITableViewDelegate {
    // Method to give a height for the footer
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    // Method to give a bit of a buffer
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // Method to adjust the height based on section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ( section == 2 && baseArray[1].count > 0 ) ? 25 : 0
    }
    
    // Method to setup the cell before its displayed
    // ( think of it as viewWillLoad
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero //... set the cell inset to be zero
        cell.layoutMargins = UIEdgeInsetsZero //.... needed to adjust the inset
    }
}

// MARK: - Extension of our VC for DataSource
// Practicing extending the class we wrote to use implement the data source
extension ToDoViewController: UITableViewDataSource {
    // Method to not allow editing fo the first section
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ( indexPath.section == 0 ) ? false : true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // FIRST SECTION
        if( indexPath.section == 0 ){
            let cell: AddToDoTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddToDoCell") as! AddToDoTableViewCell //.. setup the cell with cell identifier and "cast" it as an AddToDoTableViewCell
            cell.backgroundColor = UIColor.yellowColor() //... set the background color
            cell.favoriteButton.backgroundColor = UIColor.orangeColor() //.. reset the color
            
            return cell
        }
        else if( indexPath.section == 1 || indexPath.section == 2 ){ //... if its not the first section
            let currentToDo = baseArray[indexPath.section - 1][indexPath.row] //..... get the current todo from the array
            let cell: ToDoTableViewCell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as! ToDoTableViewCell //.. create the cell
            
            cell.titleLabel.text = currentToDo.title //... update the title from the current ToDo
            
            let dateStringFormatter = NSDateFormatter() //.... want to format the the date so we create a formatter
            dateStringFormatter.dateFormat = "yyyy-MM-dd" //.. its a custom format of year month date
            
            if let date = currentToDo.dueDate { //........................... unwrap the dueDate if it exists
                let dateString = dateStringFormatter.stringFromDate(date) //. get a string representation of the date
                cell.dateLabel.text = dateString //.......................... display with the label
            }
            
            cell.completeButton.backgroundColor = ( indexPath.section == 1 ) ? UIColor.redColor() : UIColor.greenColor() //.. if its section 1 change the color of the complete button to red, if not, make it green
            cell.favoriteButton.backgroundColor = ( currentToDo.favorited ) ? UIColor.blueColor() : UIColor.orangeColor() //. if its a favorite todo change the background color appropriately
            
            cell.backgroundColor = UIColor.lightGrayColor() //.. gives us some contrast for the cell
            
            cell.indexPath = indexPath //....................... store the index path for each cell
            cell.delegate = self //............................. makes us the delegate
            
            return cell
        }
        else{
            return UITableViewCell() //... if for some reason none of the code above runs, return a default boring ass cell
        }
    }
    
    // method to return the number of rows based on which section its in
    // there are only three sections
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( section == 0 ){
            return 1
        }
        else if( section == 1 ){
            return baseArray[0].count
        }
        else {
            return baseArray[1].count
        }
    }
    
    // method to return three sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    // Method to check if you can move the row as long as its not the first section
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ( indexPath.section == 1 ) ? true : false
    }
    
    // Method to allow us to move the rows
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let currentToDo = baseArray[0][sourceIndexPath.row] //................... get the current to do we want to move
        baseArray[0].removeAtIndex( sourceIndexPath.row ) //..................... remove from the index the one we want to move
        baseArray[0].insert(currentToDo, atIndex: destinationIndexPath.row) //... insert it into the new spot
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if( editingStyle == UITableViewCellEditingStyle.Delete ){
            tableView.beginUpdates()
            baseArray[indexPath.section - 1].removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        }
    }
    
    // method to give a header for the section
    // only shows up if the something is in the second section
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if( section == 2  && baseArray[1].count > 0 ){
            return "\(baseArray[1].count) Completed items"
        }
        return ""
    }
}

// extension to conform to the ToDoTVCellDelegate and implement its functions
extension ToDoViewController: ToDoTableViewCellDelegate {
    func completeToDo(indexPath: NSIndexPath) {
        var selectedToDo = baseArray[indexPath.section - 1][indexPath.row] //... get the todo from the array
        selectedToDo.completed = !selectedToDo.completed //..................... flip the state
        
        if( indexPath.section == 1 ){
            baseArray[1].append(selectedToDo)
        }
        else {
            baseArray[0].append(selectedToDo)
        }
        
        baseArray[indexPath.section-1].removeAtIndex(indexPath.row) //. remove it
        tableView.reloadData() //...................................... refresh the view
    }
    
    func favoriteToDo(indexPath: NSIndexPath) {
        var selectedToDo = baseArray[indexPath.section - 1][indexPath.row]
        selectedToDo.favorited = !selectedToDo.favorited
        
        baseArray[indexPath.section - 1][indexPath.row] = selectedToDo
        
        tableView.reloadData()
    }
}
