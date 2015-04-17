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
    var items : FDataSnapshot?
    var newStories : FDataSnapshot?
    var topStories : FDataSnapshot?
    var users : FDataSnapshot?
    
    override init() {
        
    }
    
    class var sharedInstance : DataStore {
        if (sharedDataStore == nil) {
            println("datastore initialized")
            sharedDataStore = DataStore()
        }
        return sharedDataStore!
    }
    
    func retrieveX(#endpoint: String, callback : (FDataSnapshot! -> Void)?) {
        self.ref.childByAppendingPath(endpoint).observeSingleEventOfType(.Value) { (snapshot : FDataSnapshot!) -> Void in
            if let unwrappedCallback = callback {
                unwrappedCallback(snapshot)
            }
        }
    }
    func retrieveAllItems(#callback : (FDataSnapshot! -> Void)?) { self.retrieveX(endpoint: "item", callback: callback)}
    func retrieveNewStories(#callback : (FDataSnapshot! -> Void)?) { self.retrieveX(endpoint: "newstories", callback: callback)}
    func retrieveTopStories(#callback : (FDataSnapshot! -> Void)?) { self.retrieveX(endpoint: "topstories", callback: callback)}
    func retrieveUsers(#callback : (FDataSnapshot! -> Void)?) { self.retrieveX(endpoint: "user", callback: callback)}
    func retrieveItemWithId(id : String, callback : (FDataSnapshot! -> Void)?) { self.retrieveX(endpoint: "item/\(id)", callback: callback)}
    func retrieveUserWithId(id : String, callback : (FDataSnapshot! -> Void)?) { self.retrieveX(endpoint: "user/\(id)", callback: callback)}
    
    func purge() {
        items = nil
        newStories = nil
        topStories = nil
        users = nil
    }
}
