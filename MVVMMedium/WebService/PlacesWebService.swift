//
//  PlacesWebService.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 01/08/24.
//

import Foundation
import GooglePlaces

struct PlacesWebService {
    func getPlaceList(placeType: PlaceType, completion: @escaping ([PlaceModel]?, _ error: Error?) -> ()) {
        let userLat = String(format: "%3f", LocationManager.shared.latitude)
        let userLong = String(format: "%3f", LocationManager.shared.longitude)
        
        let url = WebServiceConstants.baseURL + WebServiceConstants.placesAPI + "location=\(userLat),\(userLong)&radius=200&type=\(placeType.rawValue)&key=\(googleApiKey)"
        
        WebServiceManager.shared.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            guard let results = data["results"] as? [[String:Any]] else {return}
            completion(self.placesListFrom(placeType: placeType, results: results), nil)
        }
        
    }
    
    private func placesListFrom(placeType: PlaceType, results: [[String: Any]]) -> [PlaceModel] {
        var places = [PlaceModel]()
        for place in results {
           places.append(PlaceModel(attributes: place, type: placeType))
        }
        return places
    }
}
