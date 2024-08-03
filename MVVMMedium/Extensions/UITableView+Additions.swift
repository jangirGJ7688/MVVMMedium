//
//  UITableView+Additions.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/24.
//

import Foundation
import UIKit

open class ReusableTableViewCell: UITableViewCell {
    
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }

    public static func registerWithTable(_ table: UITableView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        table.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
}


open class ReusableCollectionViewCell: UICollectionViewCell {
    
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }

    public static func registerWithCollectionView(_ collectionView: UICollectionView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
}
