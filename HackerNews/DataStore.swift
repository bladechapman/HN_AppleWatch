//
//  DataStore.swift
//  HackerNews
//
//  Created by Blade Chapman on 4/11/15.
//  Copyright (c) 2015 Blade Chapman. All rights reserved.
//

import UIKit

var sharedDataStore : DataStore?

class DataStore: NSObject {
    
    let ref = Firebase(url: "https://hacker-news.firebaseio.com/v0/")
    override init() {
        println("init called")
    }
    
    class var sharedInstance : DataStore {
        if (sharedDataStore == nil) {
            sharedDataStore = DataStore()
        }
        
        return sharedDataStore!
    }
    
    func retrieveItems() {
        println("req initialized")
        self.ref.childByAppendingPath("topstories").observeSingleEventOfType(.Value, withBlock: { snapshot in
            println(snapshot.value[0])
            self.ref.childByAppendingPath("item/\(snapshot.value[0])").observeSingleEventOfType(.Value, withBlock: { snapshot in
                println(snapshot.value)
            })
        })
    }
}
