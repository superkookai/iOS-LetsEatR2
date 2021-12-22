//
//  RestaurantItem.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 2/12/2564 BE.
//

import UIKit
import MapKit

class RestaurantItem: NSObject, MKAnnotation, Decodable {
    var name: String?
    var cuisines:[String] = []
    var lat: Double?
    var long: Double?
    var address: String?
    var postalCode: String?
    var state: String?
    var imageURL: String?
    var restaurantID: Int?
    
    var coordinate: CLLocationCoordinate2D{
        guard let lat = lat, let long = long else { return CLLocationCoordinate2D() }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String?{
        name
    }
    
    var subtitle: String?{
        if cuisines.isEmpty {
            return ""
        }else if cuisines.count == 1{
            return cuisines.first
        }else{
            return cuisines.joined(separator: ", ")
        }
    }
    
//    //Use this init with fetch data from plist
//    init(dict:[String:AnyObject]){
//        if let lat = dict["lat"] as? Double { self.lat = lat }
//        if let long = dict["long"] as? Double { self.long = long }
//        if let name = dict["name"] as? String { self.name = name }
//        if let cuisines = dict["cuisines"] as? [String] { self.cuisines = cuisines }
//        if let address = dict["address"] as? String { self.address = address }
//        if let postalCode = dict["postalCode"] as? String { self.postalCode = postalCode }
//        if let state = dict["state"] as? String { self.state = state }
//        if let image = dict["image_url"] as? String { self.imageURL = image }
//        if let id = dict["id"] as? Int { self.restaurantID = id }
//        
//    }

    enum CodingKeys: String, CodingKey {
        case name
        case cuisines
        case lat
        case long
        case address
        case postalCode = "postal_code"
        case state
        case imageURL = "image_url"
        case restaurantID = "id"
        
    }

 
}
