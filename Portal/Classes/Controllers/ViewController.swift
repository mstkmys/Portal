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
        let node = ARObject.createSpace()
        [node].forEach{ sceneView.scene.rootNode.addChildNode($0) }
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






















