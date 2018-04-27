//
//  ARObject.swift
//  Portal
//
//  Created by Miyoshi Masataka on 2018/04/28.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

struct ARObject {
    
    public static var width: CGFloat = 0.2
    public static var height: CGFloat = 1.0
    public static var length: CGFloat = 1.0
    
    public static var doorLength: CGFloat = 0.3
    
    public static func createBox(isDoor: Bool) -> SCNNode {
        let node = SCNNode()
        // first box
        let firstBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
        let firstBoxNode = SCNNode(geometry: firstBox)
        firstBoxNode.renderingOrder = 200
        // masked box
        let maskedBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
        maskedBox.firstMaterial?.diffuse.contents = UIColor.white
        maskedBox.firstMaterial?.transparency = 0.00001
        let maskedBoxNode = SCNNode(geometry: maskedBox)
        maskedBoxNode.renderingOrder = 100
        maskedBoxNode.position = SCNVector3.init(width, 0, 0)
        // add box
        [firstBoxNode, maskedBoxNode].forEach{ node.addChildNode($0) }
        return node
    }
    
}



























