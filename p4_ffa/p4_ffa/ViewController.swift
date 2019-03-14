//
//  ViewController.swift
//  p4_ffa
//
//  Created by Jonathan on 3/5/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        int x = 5
        
        let gameRect: CGRect
        override init(size: CGSize){
            
            
            let maxRatio: CGFloat = 16.0/9.0
            let playableWidth = size.height / maxRatio
            let margin = (size.width - playableWidth) / 2
            
            gameRect = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
            super.init(size: size)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func didMove(to view: SKView) {
            
            self.physicsWorld.contactDelegate = self
            ironMan.setScale(10)
            ironMan.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
            ironMan.zPosition = 2
            ironMan.physicsBody = SKPhysicsBody(rectangleOf: ironMan.size)
            ironMan.physicsBody!.affectedByGravity = false
            ironMan.physicsBody!.categoryBitMask = PhysicsCat.IronMan
            ironMan.physicsBody!.collisionBitMask = PhysicsCat.None
            ironMan.physicsBody!.contactTestBitMask = PhysicsCat.Enemy
            
            
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

