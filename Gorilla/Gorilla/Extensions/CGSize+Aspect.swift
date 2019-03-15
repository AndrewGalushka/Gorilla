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
        let scaleRatio = self.height / self.width
        return round(fittingWidth * scaleRatio)
    }
    
    func widthToAspectFit(inHeight fittingHeight: CGFloat) -> CGFloat {
        let scaleRatio = self.height / self.width
        return round(fittingHeight * scaleRatio)
    }
    
    func sizeToAspectFit(inSize targetSize: CGSize) -> CGSize {
        let scaleRatio = min(targetSize.width / self.width, targetSize.height / self.height)
        return CGSize(width: round(self.width * scaleRatio), height: round(self.height * scaleRatio))
    }
}
