//
//  CategoriesTableCollectionCellVM.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation

class CategoriesTableCollectionCellVM: TableCollectionCellVMRepresentable {
    
    var title = ""
    var numberOfItems: Int = 0
    
    var cellSelected: (IndexPath)->() = { _ in }
    private var dataSource: [ImageAndLabelCollectionCellVM] = [ImageAndLabelCollectionCellVM]()
    
    init() {
        prepareDataSource()
        configureOutput()
    }
    
    private func prepareDataSource() {
        for type in PlaceType.allPlaceType() {
            dataSource.append(ImageAndLabelCollectionCellVM(dataModel: ImageAndLabelCollectionCellModel(name: type.displayText(), imageUrl: type.iconUrl())))
        }
    }
    
    private func configureOutput() {
        title = "Want to be more specific"
        numberOfItems = dataSource.count
    }
    
    func viewModelForCell(indexPath: IndexPath) -> ImageAndLabelCollectionCellVM {
       return dataSource[indexPath.item]
    }
    
    func cellSelected(indexPath: IndexPath) {
        cellSelected(indexPath)
    }
}
