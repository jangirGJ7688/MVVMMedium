//
//  PlaceTableCellVM.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation

class PlaceTableCellVM {
    
    private var place: PlaceModel!
    
    var placeViewVM: PlaceCellVM!
    var placeSelected: (PlaceModel)->() = { _ in }
    
    init(place: PlaceModel) {
        self.place = place
        preparePlaceViewVM()
    }
    
    private func preparePlaceViewVM() {
        placeViewVM = PlaceCellVM(place: place)
        placeViewVM.placesViewSelected = { [weak self] in
            guard let _self = self else { return }
            _self.placeSelected(_self.place)
        }
    }
    
}
