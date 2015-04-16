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
    var items : AnyObject?
    var newStories : AnyObject?
    var topStories : AnyObject?
    var users : AnyObject?
    
    override init() {
        
    }
    
    class var sharedInstance : DataStore {
        if (sharedDataStore == nil) {
            sharedDataStore = DataStore()
        }
        
        return sharedDataStore!
    }
    
    func retrieveX(#endpoint: String, var data: AnyObject?, callback : (Void -> Void)?) {
        self.ref.childByAppendingPath(endpoint).observeSingleEventOfType(.Value) { (snapshot : FDataSnapshot!) -> Void in
            data = snapshot.value
            if let unwrappedCallback = callback {
                unwrappedCallback()
            }
        }
    }
    func retrieveAllItems() { self.retrieveX(endpoint: "item", data: self.items, callback: nil)}
    func retrieveNewStories() { self.retrieveX(endpoint: "newstories", data: self.newStories, callback: nil)}
    func retrieveTopStores() { self.retrieveX(endpoint: "topstories", data: self.topStories, callback: nil)}
    func retrieveUsers() { self.retrieveX(endpoint: "user", data: self.users, callback: nil)}
    
    
}
