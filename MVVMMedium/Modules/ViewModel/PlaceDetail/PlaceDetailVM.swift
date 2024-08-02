//
//  PlaceDetailVM.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation
import CoreLocation

class PlaceDetailVM {
    
    var title = ""
    var location: CLLocation? = nil
    var distance = ""
    var openStatus = ""
    
    private var place: PlaceModel!
    
    init(place: PlaceModel) {
        self.place = place
        configureOutput()
    }
    
    private func configureOutput() {
        title = place.name ?? ""
        let openStat = place.openStatus ?? false
        openStatus = openStat ? "Open" : "Close"
        location = place.location
        let currentLocation = CLLocation(latitude: LocationManager.shared.latitude, longitude: LocationManager.shared.longitude)
        guard let distance = place.location?.distance(from: currentLocation) else { return }
        self.distance = String(format: "%.2f mi", distance/1609.344)
    }
}
