//
//  PaginationCellVM.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation

class PaginationCellVM {
    var numberOfPages = 0
    var title = ""
    private var dataSource = [PlaceModel]()
    var placeSelected: (PlaceModel) -> ()?
    init(data: [PlaceModel], placeSelected: @escaping (PlaceModel) -> ()) {
        self.dataSource = data
        self.placeSelected = placeSelected
        configureOutput()
    }
    
    private func configureOutput() {
        numberOfPages = dataSource.count
        title = "Hot picks only for you"
    }
    
    func viewModelForPlaceView(position: Int) -> PlaceCellVM {
        let place = dataSource[position]
        let placeViewVM = PlaceCellVM(place: place)
        placeViewVM.placesViewSelected = { [weak self] in
            self?.placeSelected(place)
        }
        return placeViewVM
    }
    
}
