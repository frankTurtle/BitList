//
//  NewToDoViewController.swift
//  BitList
//
//  Created by Mr. Nobel on 6/23/16.
//  Copyright © 2016 Mr. Nobel. All rights reserved.
//

import UIKit

class NewToDoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func completeBarButtonItemPressed(sender: UIBarButtonItem) {
    }
    
    @IBAction func favoriteBarButtonItemPressed(sender: UIBarButtonItem) {
    }
    
    @IBAction func deleteBarButtonItemPressed(sender: UIBarButtonItem) {
    }
}
