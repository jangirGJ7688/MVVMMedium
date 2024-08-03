//
//  PlaceView.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/2024.
//

import UIKit
import SDWebImage

@IBDesignable
class PlaceView: UIView {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    private var viewModel: PlaceCellVM!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    func loadXib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PlaceView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func preparePlaceView(viewModel: PlaceCellVM) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        placeNameLabel.text = viewModel.name
        distanceLabel.text = viewModel.distance
        placeImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        placeImageView.sd_setImage(with: URL(string: viewModel.placeImageUrl), placeholderImage: UIImage(named : "PlacesPlaceholder"))
    }
    
    @IBAction func placeViewTapped(_ sender: Any) {
        viewModel.placesViewPressed()
    }
}
