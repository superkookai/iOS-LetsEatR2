//
//  LocationDataManager.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 2/12/2564 BE.
//

import Foundation

class LocationDataManager{
    
//    private var locations: [String] = []
    
    private var locations: [LocationItem] = []
    
    private func loadData() -> [[String:AnyObject]]{
        
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "plist"), let items = NSArray(contentsOfFile: path) else { return  [[:]]}
        
        return items as! [[String:AnyObject]]
    }
    
    func fetch() {
        for locationDict in loadData(){
            locations.append(LocationItem(dict: locationDict))
        }
    }
    
    func numberOfItems() -> Int{
        locations.count
    }
    
    func locationItem(at index: IndexPath) -> LocationItem{
        locations[index.row]
    }
    
    func findLocation (by name: String) -> (isFound: Bool, position: Int) {
        guard let index = locations.firstIndex(where: { $0.city == name }) else {
            return (isFound: false, position: 0)
        }
        return (isFound: true, position: index)
    }
}
