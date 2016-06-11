//
//  ToDoModel.swift
//  BitList
//
//  Created by Mr. Nobel on 6/11/16.
//  Copyright © 2016 Mr. Nobel. All rights reserved.
//

import Foundation

// Enum to give us some repeat names with raw values
enum RepeatType: Int {
    case Daily = 0, Weekly, Monthly, Yearly
}

// Struct to give us a template for all ToDo's
struct ToDoModel {
    var title: String //........... holds the title of the todo
    var favorited: Bool //......... is is a favorite?
    var completed: Bool //......... have we completed?
    var dueDate:  NSDate? //....... when is is due?
    var reminder: NSDate? //....... is there a reminder?
    var repeated: RepeatType? //... if its repeated
}