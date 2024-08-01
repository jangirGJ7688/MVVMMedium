//
//  PlaceModel.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 01/08/24.
//

import Foundation
import CoreLocation

enum PlaceType: String {
    case restaurant = "restaurant"
    case atm = "atm"
    case nightClub = "night_club"
    case cafe = "cafe"
    
    static func allPlaceType() -> [PlaceType] {
        return [.restaurant, .atm, .nightClub, .cafe]
    }
    
    func iconUrl() -> String {
        switch self {
        case .restaurant:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png"
        case .atm:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png"
        case .nightClub:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/bar-71.png"
        case .cafe:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/cafe-71.png"
        }
    }
    
    func displayText() -> String {
        switch self {
        case .restaurant:
            return "Restaurant"
        case .atm:
            return "ATM"
        case .nightClub:
            return "Night Club"
        case .cafe:
            return "Cafe"
        }
    }
    
    func homeCellTitleText() -> String {
        switch self {
        case .restaurant:
            return "Top Restaurants around you"
        case .atm:
            return "Closest ATMs around you"
        case .nightClub:
            return "Top Nightclubs around you"
        case .cafe:
            return "Top Cafes around you"
        }
    }
}


struct PlaceModel {
    var name: String?
    var address: String?
    var location: CLLocation?
    var type: PlaceType?
    var imageURL: String?
    var rating: Double?
    var openStatus: Bool?
    
    init(attributes: [String:Any], type: PlaceType) {
        self.type = type
        self.address = attributes["vicinity"] as? String
        self.name = attributes["name"] as? String
        self.rating = attributes["rating"] as? Double
        
        if let openingHours = attributes["opening_hours"] as? [String:Any] {
            self.openStatus = openingHours["open_now"] as? Bool
        }
        setLocation(attributes: attributes)
        setImageURL(attributes: attributes)
    }
    
    private mutating func setLocation(attributes: [String:Any]) {
        guard let geo = attributes["geometry"] as? [String:Any], let location = geo["location"] as? [String:Any], let lat = location["lat"] as? Double, let long = location["long"] as? Double else {
            return
        }
        self.location = CLLocation(latitude: lat, longitude: long)
    }
    
    private mutating func setImageURL(attributes: [String:Any]) {
        guard let photos = attributes["photos"] as? [[String:AnyObject]] else {
            return
        }
        guard photos.count > 0 else {
            return
        }
        guard let photoRefrence = photos[0]["photo_reference"] as? String else {
            return
        }
        self.imageURL = WebServiceConstants.baseURL + WebServiceConstants.imageAPI + "maxwidth=200&" + "photoreference=\(photoRefrence)&key=\(googleApiKey)"
    }
    
}
