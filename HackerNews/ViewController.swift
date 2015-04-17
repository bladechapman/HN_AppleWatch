//
//  ViewController.swift
//  HackerNews
//
//  Created by Blade Chapman on 4/11/15.
//  Copyright (c) 2015 Blade Chapman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var store = DataStore.sharedInstance
        store.retrieveTopStories(callback: { (data : FDataSnapshot!) -> Void in
            store.topStories = data
            self.newsTable.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var store = DataStore.sharedInstance
        
        var cell = newsTable.dequeueReusableCellWithIdentifier("itemCell") as! UITableViewCell
        if let label : AnyObject = store.topStories?.value[indexPath.row] {
            store.retrieveItemWithId(String(stringInterpolationSegment: store.topStories!.value[indexPath.row]), callback: { (data : FDataSnapshot!) -> Void in
                
                if let title : AnyObject = data.value["title"] {
                    cell.textLabel!.text = "\(indexPath.row) : \(title)"
                }
                else {
                    cell.textLabel!.text = "\(indexPath.row)"
                }
            })
        }
        else {
            cell.textLabel!.text = "\(indexPath.row)"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var store = DataStore.sharedInstance
        if let count = store.topStories?.childrenCount {
            return Int(count)
        }
        else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}

