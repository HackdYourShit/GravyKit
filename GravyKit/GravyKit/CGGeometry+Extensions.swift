//
//  CGGeometry+Extensions.swift
//  Common
//
//  Created by Oleksandr Kradenkov on 7/11/19.
//  Copyright © 2019 Kradenkov PE. All rights reserved.
//

import CoreGraphics.CGGeometry

extension CGSize {
    public var minEdgeSize: CGFloat {
        return min(self.width, self.height)
    }
    
    public var maxEdgeSize: CGFloat {
        return max(self.width, self.height)
    }
}
