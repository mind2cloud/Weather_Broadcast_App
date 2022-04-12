//
//  ParticlesView.swift
//  WeatherBroadcast
//
//  Created by Roman Kochnev on 11.03.2018.
//  Copyright © 2018 Roman Kochnev. All rights reserved.
//

import UIKit
import SpriteKit

class ParticlesView: SKView {
    override func didMoveToSuperview() {
        
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = UIColor.clear
        self.presentScene(scene)
        
        self.allowsTransparency = true
        self.backgroundColor = UIColor.clear
        
        if let particles = SKEmitterNode(fileNamed: "ParticleScene.sks") {
            particles.position = CGPoint(x: self.frame.size.width - 140, y: self.frame.size.height)
            particles.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
            
            scene.addChild(particles)
        }
    }

}
