//
//  MapDataManager.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 2/12/2564 BE.
//

import Foundation
import MapKit

class MapDataManager: DataManager{
    
    fileprivate var items: [RestaurantItem] = []
    
    var annotations: [RestaurantItem]{
        items
    }
    
    func fetch(completion: (_ annotations:[RestaurantItem]) -> ()){
        
        //use this code for fetch data from json
        let manager = RestaurantDataManager()
        manager.fetch(by: "Boston") { (items) in
            self.items = items
            completion(items)
        }
        
        
        //use this code for fetch data from plist
//        if items.count > 0{
//            items.removeAll()
//        }
//        for data in load(file: "MapLocations"){
//            items.append(RestaurantItem(dict: data))
//        }
//        completion(items)
    }
    
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion{
        guard let item = items.first else { return MKCoordinateRegion() }
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
}
