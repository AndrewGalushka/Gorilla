//
//  FeedViewControllerPresenter.swift
//  Gorilla
//
//  Created by Galushka on 3/13/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

class FeedViewControllerPresenter {
    
    // MARK: Properties(Public)
    
    weak var searchInteractor: ImgurGallerySearchInteractorType?
    weak var view: FeedViewControllerPresenterOutput?
    
    // MARK: Properties(Private)
    
    private var convertor = FeedViewControllerPresenterModelsConvertor()
    private let postImageFetcher = PostImageFetchingService(imageFetcher: ImageFetcher())
}

extension FeedViewControllerPresenter: FeedViewOutput {
    func itemSize(for imageViewCellViewModel: FeedCollectionImageViewCellViewModel, in collectionView: UICollectionView, style: FeedViewController.CollectionViewLayoutType) -> CGSize {
        
        guard
            let searchInteractor = searchInteractor,
            let post = (searchInteractor.lastSearchingResults.first(where: { $0.identifier ==  imageViewCellViewModel.identifier})),
            let firstImageOfPost = post.images?.first,
            let imagePixWidth = firstImageOfPost.width,
            let imagePixHeight = firstImageOfPost.height
        else {
            return CGSize.zero
        }
        
        let screenScale = UIScreen.main.scale
        let imagePointSize = CGSize(width: CGFloat(imagePixWidth) / screenScale, height: CGFloat(imagePixHeight) / screenScale)
        
        let itemWidth: CGFloat
        
        switch style {
        case .plain:
            itemWidth = collectionView.bounds.width
        case .grid:
            itemWidth = collectionView.bounds.width / 2.0
        }
        
        let itemHeight = imagePointSize.heightToAspectFit(inWidth: itemWidth)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func feedView(_ feedViewController: FeedViewController, didTapSearchText searchQuery: String?) {
        guard let searchInteractor = searchInteractor else {
            return
        }
        
        guard let searchQuery = searchQuery else {
            view?.displaySearchResults([])
            return
        }
        
        let searchParms = ImgurAPI.Gallery.Search.Params(query: searchQuery, sort: .top, size: .small, type: .jpg)
        
        searchInteractor.search(by: searchParms) { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let gallerySearchResults):
                strongSelf.view?.displaySearchResults(strongSelf.convertor.convert(searchResults: gallerySearchResults))
            case .failure(let error):
                print(error)
                strongSelf.view?.displaySearchResults([])
            }
        }
    }
    
    func willDisplay(_ imageViewModel: FeedCollectionImageViewCellViewModel) {
        
        guard
            let relatedPost = self.searchInteractor?.lastSearchingResults.first(where: { $0.identifier ==  imageViewModel.identifier}),
            let firstImage = relatedPost.images?.first
        else { return }
        
        self.postImageFetcher.fetch(firstImage) { (response) in
            switch response {
            case .success(let image):
                imageViewModel.image.value = image
            case .failure(_): break
            }
        }
    }
    
    func didEndDisplaying(_ imageViewModel: FeedCollectionImageViewCellViewModel) {
    }
}
