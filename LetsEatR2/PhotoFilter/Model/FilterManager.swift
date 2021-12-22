//
//  FilterManager.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 14/12/2564 BE.
//

import Foundation

class FilterManager: DataManager{
    
    func fetch(completionHandler: (_ items: [FilterItem]) -> Void){
        var items: [FilterItem] = []
        for data in load(file: "FilterData"){
            items.append(FilterItem(dict: data))
        }
        completionHandler(items)
    }
}
