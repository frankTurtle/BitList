//
//  ToDoViewController.swift
//  BitList
//
//  Created by Mr. Nobel on 6/11/16.
//  Copyright © 2016 Mr. Nobel. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var baseArray: [[ToDoModel]] = [] //......... multi-dimensional array full of completed / not tasks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    
        // create some toDo's
        let toDo1 = ToDoModel(title: "Study", favorited: false, completed: false, dueDate: NSDate(), reminder: nil, repeated: nil)
        let toDo2 = ToDoModel(title: "Dinner", favorited: false, completed: false, dueDate: nil, reminder: nil, repeated: nil)
        let toDo3 = ToDoModel(title: "Gym", favorited: false, completed: false, dueDate: nil, reminder: nil, repeated: nil)
        
        baseArray = [[toDo1, toDo2, toDo3], []] //..... add them to the first array as they're not completed yet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editBarButtonItemPressed(sender: UIBarButtonItem) {
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // FIRST SECTION
        if( indexPath.section == 0 ){
            let cell: AddToDoTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddToDoCell") as! AddToDoTableViewCell //.. setup the cell with cell identifier and "cast" it as an AddToDoTableViewCell
            cell.backgroundColor = UIColor.yellowColor() //... set the background color
            
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
    
}
