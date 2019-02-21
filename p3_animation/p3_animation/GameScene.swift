//
//  GameScene.swift
//  p3_animation
//
//  Created by Jonathan on 2/17/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let ironMan = SKSpriteNode(imageNamed: "ironman")
    
    override func didMove(to view: SKView) {
        
        ironMan.setScale(10)
        ironMan.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        ironMan.zPosition = 2
        self.addChild(ironMan)
    }
    
    
    func fireIron(){
        let laser = SKSpriteNode(imageNamed: "ironmanblast")
        laser.setScale(1)
        laser.position = ironMan.position
        laser.zPosition = 1
        self.addChild(laser)
        
        let moveLaser = SKAction.moveTo(y: self.size.height + laser.size.height , duration: 1)
        let deleteLaser = SKAction.removeFromParent()
    
        let laserSequence = SKAction.sequence([moveLaser, deleteLaser])
        laser.run(laserSequence)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireIron()
    }
    
}
