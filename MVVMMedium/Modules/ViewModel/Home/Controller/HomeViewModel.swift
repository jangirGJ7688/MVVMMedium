//
//  HomeViewModel.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 01/08/24.
//

import Foundation


enum HomeTableCellType {
    case pagingCell(model: PaginationCellVM)
    case categoriesCell(model: TableCollectionCellVMRepresentable)
    case placesCell(model: TableCollectionCellVMRepresentable)
}

class HomeViewModel {
    
    private var tableDataSource = [HomeTableCellType]()
    var viewDidLoad: () -> () = {}
    var placeSelected: (PlaceModel) -> () = {_ in }
    var categorySelected: (PlaceType)->() = { _ in }
    var reloadTable: ()->() = { }
    
    var numberOfRows = 0
    
    init() {
        viewDidLoad = { [weak self] in
            self?.getAppData(completion: {
                self?.prepareTableDataSource()
                self?.reloadTable()
            })
        }
    }
    
    func refreshScreen() {
        tableDataSource.removeAll()
        self.getAppData(completion: { [weak self] in
            self?.prepareTableDataSource()
            self?.reloadTable()
        })
    }
    
    private func getAppData(completion: @escaping ()->()) {
        let allPlaces = PlaceType.allPlaceType()
        var dataReceivedCount = 0
        var places = [PlaceModel]()
        for placeType in allPlaces {
            PlacesWebService().getPlaceList(placeType: placeType) { (placeList, error) in
                if placeList != nil {
                    places+=placeList!
                }
                dataReceivedCount+=1
                guard dataReceivedCount == allPlaces.count else { return }
                AppData.sharedData.resetData()
                AppData.sharedData.allPlaces = places
                completion()
            }
        }
    }
    
    private func prepareTableDataSource() {
        tableDataSource.append(cellTypeForPagingCell())
        tableDataSource.append(cellTypeForCategoriesCell())
        tableDataSource.append(contentsOf: cellTypeForPlaces())
        numberOfRows = tableDataSource.count
    }
    
    private func cellTypeForPagingCell()->HomeTableCellType {
        var places = [PlaceModel]()
        for placeType in PlaceType.allPlaceType() {
            places.append(contentsOf: Helper.getTopPlace(paceType: placeType, topPlacesCount: 1))
        }
        let placeSelected: (PlaceModel)->() = { [weak self] place in
            
            self?.placeSelected(place)
        }
        return HomeTableCellType.pagingCell(model: PaginationCellVM(data: places, placeSelected: placeSelected))
    }
    
    private func cellTypeForCategoriesCell()->HomeTableCellType {
        let categorieVM = CategoriesTableCollectionCellVM()
        categorieVM.cellSelected = { [weak self] indexPath in
            self?.categorySelected(PlaceType.allPlaceType()[indexPath.row])
        }
        return HomeTableCellType.categoriesCell(model: categorieVM)
    }
    
    private func cellTypeForPlaces()->[HomeTableCellType] {
        var cellTypes = [HomeTableCellType]()
        let allPlaceTypes = PlaceType.allPlaceType()
        for type in allPlaceTypes {
            let topPlaces = Helper.getTopPlace(paceType: type, topPlacesCount: 3)
            let placeCellVM = PlacesTableCollectionCellVM(dataModel: PlacesTableCollectionCellModel(places: topPlaces, title: type.homeCellTitleText()))
            placeCellVM.cellSelected = { [weak self] indexPath in
                self?.placeSelected(topPlaces[indexPath.item])
            }
            if topPlaces.count > 0 {
                cellTypes.append(HomeTableCellType.placesCell(model: placeCellVM))
            }
        }
        return cellTypes
    }
      
    func cellType(forIndex indexPath: IndexPath)->HomeTableCellType {
        return tableDataSource[indexPath.row]
    }
}
