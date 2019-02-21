//
//  FeedCollectionImageViewCell.swift
//  Gorilla
//
//  Created by Galushka on 2/21/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

class FeedCollectionImageViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension FeedCollectionImageViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}
