//
//  ImageAndLabelCollectionCellVM.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation

struct ImageAndLabelCollectionCellModel {
    var name: String = ""
    var imageUrl: String = ""
}

class ImageAndLabelCollectionCellVM {
    private var dataModel: ImageAndLabelCollectionCellModel!
    var imageURL: String!
    var text: String!
    
    init(dataModel: ImageAndLabelCollectionCellModel) {
        self.dataModel = dataModel
        configureOutput()
    }
    
    private func configureOutput() {
        imageURL = dataModel.imageUrl
        text = dataModel.name
    }
}
