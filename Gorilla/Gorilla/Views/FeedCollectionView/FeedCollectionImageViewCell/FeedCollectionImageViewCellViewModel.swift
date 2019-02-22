//
//  FeedCollectionImageViewCellViewModel.swift
//  Gorilla
//
//  Created by Galushka on 2/21/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit
import RxSwift

class FeedCollectionImageViewCellViewModel {
    let identifier: String
    var imageURL: Variable<UIImage?> = Variable(nil)
    
    init(identifier: String) {
        self.identifier = identifier
    }
}
