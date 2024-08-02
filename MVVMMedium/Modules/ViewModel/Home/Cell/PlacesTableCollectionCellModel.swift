//
//  PlacesTableCollectionCellModel.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation

protocol TableCollectionCellVMRepresentable {
    var title: String {get}
    var numberOfItems: Int {get}
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM
    func cellSelected(indexPath: IndexPath)
    var cellSelected: (IndexPath) -> () {get}
}

struct PlacesTableCollectionCellModel {
    var places = [PlaceModel]()
    var title = ""
    init(places: [PlaceModel] = [PlaceModel](), title: String = "") {
        self.places = places
        self.title = title
    }
}

class PlacesTableCollectionCellVM: TableCollectionCellVMRepresentable {
    var title: String = ""
    var numberOfItems: Int = 0
    var cellSelected: (IndexPath) -> () = { _ in }
    private var dataModel: PlacesTableCollectionCellModel?
    private var dataSource = [ImageAndLabelCollectionCellVM]()
    
    init(dataModel: PlacesTableCollectionCellModel) {
        self.dataModel = dataModel
        prepareCollectionDataSource()
        configureOutput()
    }
    
    private func configureOutput() {
        title = dataModel?.title ?? ""
        numberOfItems = dataSource.count
    }
    
    private func prepareCollectionDataSource() {
        guard let model = dataModel else {return}
        if model.places.isEmpty {return}
        let totalItems = model.places.count >= 3 ? 3 : model.places.count
        for i in 0..<totalItems {
            let place = model.places[i]
            if let placeName = place.name, let placeImageUrl = place.imageURL {
                let imageAndLabelDm = ImageAndLabelCollectionCellModel(name: placeName, imageUrl: placeImageUrl)
                dataSource.append(ImageAndLabelCollectionCellVM(dataModel: imageAndLabelDm))
            }
        }
    }
    
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM {
        return dataSource[indexPath.row]
    }
    
    func cellSelected(indexPath: IndexPath) {
        cellSelected(indexPath)
    }
}
