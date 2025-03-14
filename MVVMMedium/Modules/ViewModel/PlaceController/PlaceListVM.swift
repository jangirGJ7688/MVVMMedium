//
//  PlaceListVM.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation

class PlaceListVM {

    var numberOfRows = 0
    var title = ""
    
    private var placeType: PlaceType!
    private var dataSource = [PlaceTableCellVM]()
    
    // Event
    var placeSelected: (PlaceModel)->() = { _ in }
    
    init(placeType: PlaceType) {
        self.placeType = placeType
        prepareTableDataSource()
        configureOutput()
    }
    
    private func prepareTableDataSource() {
        dataSource = AppData.sharedData.allPlaces.filter { $0.type == placeType }.map {  return PlaceTableCellVM(place: $0) }
    }
    
    private func configureOutput() {
        title = placeType.displayText()
        numberOfRows = dataSource.count
    }
    
    func cellViewModel(indexPath: IndexPath)->PlaceTableCellVM {
        let cellViewModel = dataSource[indexPath.row]
        cellViewModel.placeSelected = placeSelected
        return cellViewModel
    }
}
