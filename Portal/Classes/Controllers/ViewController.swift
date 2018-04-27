//
//  ViewController.swift
//  Portal
//
//  Created by Miyoshi Masataka on 2018/04/28.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    private let arView: ARView = {
        let view = ARView(frame: UIScreen.main.bounds)
        return view
    }()
    
    private var sceneView: ARSCNView {
        return arView.sceneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [arView].forEach{ self.view.addSubview($0) }
        sceneView.delegate = self
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    private func setupScene() {
        let node = SCNNode()
        node.position = SCNVector3.init(0, 0, 0)
        // wall
        let leftWall = ARObject.createBox(isDoor: false)
        leftWall.position = SCNVector3.init(-ARObject.length / 2, 0, 0)
        let rightWall = ARObject.createBox(isDoor: false)
        rightWall.position = SCNVector3.init(ARObject.length / 2, 0, 0)
        let topWall = ARObject.createBox(isDoor: false)
        topWall.position = SCNVector3.init(0, ARObject.length / 2, 0)
        let bottomWall = ARObject.createBox(isDoor: false)
        bottomWall.position = SCNVector3.init(0, -ARObject.length / 2, 0)
        let backWall = ARObject.createBox(isDoor: false)
        backWall.position = SCNVector3.init(0, 0, -ARObject.length / 2)
        // door side
        let leftDoorSide = ARObject.createBox(isDoor: true)
        leftDoorSide.position = SCNVector3.init(-ARObject.doorLength / 2, 0, ARObject.length / 2)
        let rightDoorSdie = ARObject.createBox(isDoor: true)
        rightDoorSdie.position = SCNVector3.init(-ARObject.doorLength / 2, 0, ARObject.length / 2)
        // add nodes
        [leftWall, rightWall, topWall, bottomWall, backWall, leftDoorSide, rightDoorSdie].forEach{ node.addChildNode($0) }
        sceneView.scene.rootNode.addChildNode(node)
    }
    
}

// MARK: - ARSCNViewDelegate
/*******************************************************************************************/
extension ViewController: ARSCNViewDelegate {
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
}






















