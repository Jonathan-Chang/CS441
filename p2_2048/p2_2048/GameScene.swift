//
//  GameScene.swift
//  p2_2048
//
//  Created by Jonathan on 1/30/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(color: .red, size: CGSize(width:100, height:100))
        background.size = self.size
        self.addChild(background)
        
        
        //Create the gameboard
        
        drawBoard()
        
        
        
        
        
        
        
        
    }
    
    
    func drawBoard() {
        static let radius: CGFloat = 4.0
        
        let dimension: Int
        let tileSize : CGSize
        var padding: CGFloat = 8
    
    
    
    
    
}
