//
//  FeedCollectionImageViewCell.swift
//  Gorilla
//
//  Created by Galushka on 2/21/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit
import RxSwift

class FeedCollectionImageViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    private(set) var viewModel: FeedCollectionImageViewCellViewModel?
    
    private var disposeBag: DisposeBag?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        unsubscribe()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1.0
    }
    
    func configure(viewModel: FeedCollectionImageViewCellViewModel?) {
        self.viewModel = viewModel
        imageView.image = viewModel?.imageURL.value
        
        subscribe(on: viewModel)
    }
    
    private func subscribe(on viewModel: FeedCollectionImageViewCellViewModel?) {
        unsubscribe()
        
        if let viewModel = viewModel {
            let imageURLDispose = viewModel.imageURL.asObservable().subscribe(onNext: { (image) in
                self.imageView.image = image
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
            self.disposeBag = DisposeBag(disposing: [imageURLDispose])
        }
    }
    
    private func unsubscribe() {
        self.disposeBag = nil
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
