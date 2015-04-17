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
    
    func retrieveX(#endpoint: String, callback : (AnyObject? -> Void)?) {
        self.ref.childByAppendingPath(endpoint).observeSingleEventOfType(.Value) { (snapshot : FDataSnapshot!) -> Void in
            if let unwrappedCallback = callback {
                unwrappedCallback(snapshot.value)
            }
        }
    }
    func retrieveAllItems(#callback : (AnyObject? -> Void)?) { self.retrieveX(endpoint: "item", callback: callback)}
    func retrieveNewStories(#callback : (AnyObject? -> Void)?) { self.retrieveX(endpoint: "newstories", callback: callback)}
    func retrieveTopStories(#callback : (AnyObject? -> Void)?) { self.retrieveX(endpoint: "topstories", callback: callback)}
    func retrieveUsers(#callback : (AnyObject? -> Void)?) { self.retrieveX(endpoint: "user", callback: callback)}
    
    
}
