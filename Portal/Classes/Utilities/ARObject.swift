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
    
    private static var width: CGFloat = 0.02
    private static var height: CGFloat = 1.0
    private static var length: CGFloat = 1.0
    private static var doorLength: CGFloat = 0.0
    
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
    
    public static func createSpace() -> SCNNode {
        let node = SCNNode()
        node.position = SCNVector3.init(0, 0, (-length * 1.5))
        // wall
        let leftWall = self.createBox(isDoor: false)
        leftWall.position = SCNVector3.init((-length / 2) + width, 0, 0)
        leftWall.eulerAngles = SCNVector3.init(0, 180.0.degreesToRadius, 0)
        let rightWall = self.createBox(isDoor: false)
        rightWall.position = SCNVector3.init((length / 2) - width, 0, 0)
        let topWall = self.createBox(isDoor: false)
        topWall.position = SCNVector3.init(0, (length / 2) - width, 0)
        topWall.eulerAngles = SCNVector3.init(0, 0, 90.0.degreesToRadius)
        let bottomWall = self.createBox(isDoor: false)
        bottomWall.position = SCNVector3.init(0, (-length / 2) + width, 0)
        bottomWall.eulerAngles = SCNVector3.init(0, 0, -90.0.degreesToRadius)
        let backWall = self.createBox(isDoor: false)
        backWall.position = SCNVector3.init(0, 0, (-length / 2) + width)
        backWall.eulerAngles = SCNVector3.init(0, 90.0.degreesToRadius, 0)
        
        // video
        let videoNode = self.createVideoNode()
        videoNode.position = SCNVector3.init(0, 0, -0.3)
        
        // door side
        let leftDoorSide = self.createBox(isDoor: true)
        leftDoorSide.position = SCNVector3.init((-length / 2) + (doorLength / 2), 0, length / 2)
        leftDoorSide.eulerAngles = SCNVector3.init(0, -90.0.degreesToRadius, 0)
        let rightDoorSdie = self.createBox(isDoor: true)
        rightDoorSdie.position = SCNVector3.init((length / 2) - (doorLength / 2), 0, length / 2)
        rightDoorSdie.eulerAngles = SCNVector3.init(0, -90.0.degreesToRadius, 0)
        // create light
        let light = SCNLight()
        light.type = .spot
        light.spotInnerAngle = 300
        light.spotOuterAngle = 300
        light.zNear = 0.00001
        light.zFar = 5
        light.castsShadow = true
        light.shadowRadius = 200
        light.shadowColor = UIColor.clear
        light.shadowMode = .deferred
        let constraint = SCNLookAtConstraint(target: bottomWall)
        constraint.isGimbalLockEnabled = true
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3.init(0, -(length / 2), 0)
        lightNode.constraints = [constraint]
        // add nodes
        [leftWall, rightWall, topWall, bottomWall, backWall, leftDoorSide, rightDoorSdie, lightNode, videoNode].forEach{ node.addChildNode($0) }
        return node
    }
    
    private static func createVideoNode() -> SCNNode {
        let scene = SKScene()
        scene.backgroundColor = UIColor.orange.withAlphaComponent(1)
        scene.size = CGSize(width: 500, height: 500)
        
        let bundlePath = Bundle.main.path(forResource: "cute", ofType: "mp4")!
        let videoPlayer = AVPlayer(url: URL(fileURLWithPath: bundlePath))
        videoPlayer.play()
        
        let videoNode = SKVideoNode(avPlayer: videoPlayer)
        videoNode.size = scene.size
        videoNode.position = CGPoint(x: videoNode.size.width / 2, y: videoNode.size.height / 2)
        videoNode.yScale = -1.0
        scene.addChild(videoNode)
        let videoPlane = SCNPlane(width: height, height: height)
        let node = SCNNode(geometry: videoPlane)
        node.geometry?.firstMaterial?.diffuse.contents = scene
        return node
    }
    
}



























