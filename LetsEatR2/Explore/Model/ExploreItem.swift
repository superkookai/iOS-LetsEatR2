//
//  ExploreItem.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 30/11/2564 BE.
//

import Foundation

struct ExploreItem{
    var name: String
    var image: String
}

extension ExploreItem{
    
    init(dict: [String:AnyObject]){
        self.name = dict["name"] as! String
        self.image = dict["image"] as! String
    }
}
