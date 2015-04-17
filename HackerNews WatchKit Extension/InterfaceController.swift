//
//  InterfaceController.swift
//  HackerNews WatchKit Extension
//
//  Created by Blade Chapman on 4/17/15.
//  Copyright (c) 2015 Blade Chapman. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var newsTable: WKInterfaceTable!
    var store : DataStore?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        store = DataStore.sharedInstance
        store!.retrieveTopStories(callback: { (data : FDataSnapshot!) -> Void in
            self.store!.topStories = data
            self.reloadTable()
        })

        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func reloadTable() {
        newsTable.setNumberOfRows(10, withRowType: "NewsItemRow")
        for (var i = 0; i < 10; i++) {
            if let row = newsTable.rowControllerAtIndex(i) as? NewsItemRow {
                if let rowID : AnyObject = self.store?.topStories?.value[i] {
                    self.store!.retrieveItemWithId(rowID.stringValue, callback: { (data : FDataSnapshot!) -> Void in
                        println(data.value["title"])
                        if let title : AnyObject = data.value["title"] {
                            row.titleLabel.setText(title as? String)
                        }
                        else {
                            row.titleLabel.setText("nil")
                        }
                    })
                }
                else {
                    row.titleLabel.setText("nil")
                }
            }
        }
        
    }

}
