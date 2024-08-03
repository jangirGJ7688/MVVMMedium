//
//  PlaceTableCell.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/2024.
//

import UIKit

class PlaceTableCell: ReusableTableViewCell {

    @IBOutlet weak var placeView: PlaceView!    
    
    var viewModel: PlaceTableCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(viewModel: PlaceTableCellVM) {
        self.viewModel = viewModel
        placeView.preparePlaceView(viewModel: viewModel.placeViewVM)
    }
    
}
