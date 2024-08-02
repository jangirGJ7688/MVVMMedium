//
//  PlaceCellVM.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation
import CoreLocation

protocol PlaceViewVMRepresentable {
    var placeImageUrl: String { get }
    var name: String { get }
    var distance: String { get }
    func placesViewPressed()
    var placesViewSelected: () -> () { get }
}

class PlaceCellVM {
    var placeImageUrl: String = ""
    var name: String = ""
    var distance: String = ""
    
    private var place: PlaceModel!
    var placesViewSelected: () -> () = { }
    
    init(place: PlaceModel) {
        self.place = place
        configureOutput()
    }
    
    private func configureOutput() {
        placeImageUrl = place.imageURL ?? ""
        name = place.name ?? ""
        let currentLocation = CLLocation(latitude: LocationManager.shared.latitude, longitude: LocationManager.shared.longitude)
        guard let distance = place.location?.distance(from: currentLocation) else { return }
        self.distance = String(format: "%.2f mi", distance/1609.344)
    }
    
    func placesViewPressed() {
        placesViewSelected()
    }
}
