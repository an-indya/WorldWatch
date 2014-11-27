//
//  InterfaceController.swift
//  AppleWatchDemo WatchKit Extension
//
//  Created by Anindya Sengupta on 24/11/2014.
//  Copyright (c) 2014 Anindya Sengupta. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override init(context: AnyObject?) {
        super.init(context: context)
        
        populateTable()
        
    }
    
    private func populateTable () {
        
        var plistKeys: NSDictionary?
        var timeZones: NSDictionary?
        
        if let path = NSBundle.mainBundle().pathForResource("Timezones", ofType: "plist") {
            plistKeys = NSDictionary(contentsOfFile: path)!
            timeZones = plistKeys!["TimeZones"] as NSDictionary?
        }
        if let dict = timeZones {
            table.setNumberOfRows(dict.count, withRowType: "LocalTimeRowController")
            var keyArray = dict.allKeys as [String]
            func backwards(s1: String, s2: String) -> Bool {
                return s1 < s2
            }
            var mDict = sorted(keyArray, backwards)
            for (index, key) in enumerate(mDict) {
                let row = table.rowControllerAtIndex(index) as LocalTimeRowController
                row.countryLabel.setText((key as String))
                var value: AnyObject? = dict[key as String]
                row.localTimeLabel.setTimeZone(NSTimeZone(name: value as String))
            }
        }
        
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }
    
}
