//
//  FilterItem.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 14/12/2564 BE.
//

import Foundation

class FilterItem: NSObject{
    
    let filter: String
    let name: String
    
    init(dict: [String:AnyObject]){
        self.filter = dict["filter"] as! String
        self.name = dict["name"] as! String
    }
}
