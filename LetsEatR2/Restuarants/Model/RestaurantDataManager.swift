//
//  RestaurantDataManager.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 6/12/2564 BE.
//

import Foundation

class RestaurantDataManager{
    
    private var items: [RestaurantItem] = []
    
    func fetch(by location: String, with filter: String = "All", completionHandler: (_ items:[RestaurantItem])->Void){
        
        if let file = Bundle.main.url(forResource: location, withExtension: "json"){
            do{
                let data = try Data(contentsOf: file)
                let restaurants = try JSONDecoder().decode([RestaurantItem].self, from: data)
                if filter != "All"{
                    items = restaurants.filter{$0.cuisines.contains(filter)}
                }else{
                    items = restaurants
                }
            }
            catch{
                print("There was an error: \(error)")
            }
        }
        
        completionHandler(items)
    }
    
    func numberOfItems() -> Int{
        items.count
    }
    
    func restaurantItem(at index: IndexPath) -> RestaurantItem{
        items[index.item]
    }
}
