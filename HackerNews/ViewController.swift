//
//  ViewController.swift
//  HackerNews
//
//  Created by Blade Chapman on 4/11/15.
//  Copyright (c) 2015 Blade Chapman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var store = DataStore.sharedInstance
        store.retrieveTopStories() { (data : AnyObject?) -> Void in
            println(data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

