//
//  CGSize+Aspect.swift
//  Gorilla
//
//  Created by Galushka on 3/11/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import UIKit

extension CGSize {
    
    func heightToAspectFit(inWidth fittingWidth: CGFloat) -> CGFloat {
        let scaleRatio = self.width / self.height
        return round(fittingWidth * scaleRatio)
    }
    
    func aspectFit(inHeight fittingHeight: CGFloat) -> CGSize {
        let scaleRatio = self.height / self.width
        
        return CGSize(width: width * scaleRatio, height: fittingHeight)
    }
    
    static func aspectFit(aspectRatio : CGSize, boundingSize: CGSize) -> CGSize {
        let mW = boundingSize.width / aspectRatio.width;
        let mH = boundingSize.height / aspectRatio.height;
        
        var boundingSize = boundingSize
        
        if( mH < mW ) {
            boundingSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW < mH ) {
            boundingSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return boundingSize;
    }
    
    static func aspectFill(aspectRatio :CGSize, minimumSize: CGSize) -> CGSize {
        let mW = minimumSize.width / aspectRatio.width;
        let mH = minimumSize.height / aspectRatio.height;
        
        var minimumSize = minimumSize
        
        if( mH > mW ) {
            minimumSize.width = minimumSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW > mH ) {
            minimumSize.height = minimumSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return minimumSize;
    }
}
