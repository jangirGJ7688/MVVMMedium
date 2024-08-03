//
//  ImageAndLabelCollectionCell.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/2024.
//

import UIKit
import SDWebImage

class ImageAndLabelCollectionCell: ReusableCollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    private var viewModel: ImageAndLabelCollectionCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func prepareCell(viewModel: ImageAndLabelCollectionCellVM) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        guard let viewModel = self.viewModel else { return }
        textLabel.text = viewModel.text
        imageView.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(named : "placeIcon"))
    }
    
}
