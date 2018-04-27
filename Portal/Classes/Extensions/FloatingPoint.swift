//
//  FloatingPoint.swift
//  Portal
//
//  Created by Miyoshi Masataka on 2018/04/28.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import Foundation

extension FloatingPoint {
    
    public var degreesToRadius: Self {
        return self * .pi / 180
    }
    
    public var radiusToDegrees: Self {
        return self * 180 / .pi
    }
    
}
























