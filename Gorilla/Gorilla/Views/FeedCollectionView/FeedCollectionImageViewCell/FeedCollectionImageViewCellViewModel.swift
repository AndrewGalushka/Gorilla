//
//  FeedCollectionImageViewCellViewModel.swift
//  Gorilla
//
//  Created by Galushka on 2/21/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit
import RxSwift

protocol FeedCollectionImageViewCellViewModelType {
    var identifier: String { get }
    var image: Variable<UIImage?> { get }
}

class FeedCollectionImageViewCellViewModel: FeedCollectionImageViewCellViewModelType {
    let identifier: String
    var image: Variable<UIImage?> = Variable(nil)
    
    init(identifier: String) {
        self.identifier = identifier
    }
}
