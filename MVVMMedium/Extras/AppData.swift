//
//  AppData.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation

class AppData {
    
    static let sharedData = AppData()
    var allPlaces = [PlaceModel]()
    
    func resetData() {
        allPlaces.removeAll()
    }
    
}
