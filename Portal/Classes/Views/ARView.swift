//
//  ARView.swift
//  Portal
//
//  Created by Miyoshi Masataka on 2018/04/28.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit
import ARKit

class ARView: UIView {
    
    public let sceneView: ARSCNView = {
        let view = ARSCNView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [sceneView].forEach{ self.addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        sceneView.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.safeAreaLayoutGuide.bottomAnchor,
            trailing: self.trailingAnchor
        )
        
    }
    
}
























