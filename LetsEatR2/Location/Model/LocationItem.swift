//
//  LocationItem.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 6/12/2564 BE.
//

import Foundation

struct LocationItem {
    var city: String?
    var state: String?
}

extension LocationItem{
    
    init(dict: [String:AnyObject]) {
        self.city = dict["city"] as? String
        self.state = dict["state"] as? String
    }
    
    var full: String{
        guard let city = self.city, let state = self.state else { return "" }
        return "\(city), \(state)"
    }
}
