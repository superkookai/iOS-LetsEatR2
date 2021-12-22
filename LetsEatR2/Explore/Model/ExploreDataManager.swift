//
//  ExploreDataManager.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 30/11/2564 BE.
//

import Foundation

class ExploreDataManager: DataManager{
    
    fileprivate var items: [ExploreItem] = []
    
    func fetch(){
        for data in load(file: "ExploreData"){
            items.append(ExploreItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int{
        items.count
    }
    
    func explore(at index: IndexPath) -> ExploreItem{
        items[index.item]
    }
    
//    fileprivate func loadData() -> [[String:AnyObject]]{
//
//        guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"), let items = NSArray(contentsOfFile: path) else { return [[:]] }
//
//        return items as! [[String:AnyObject]]
//    }
}
