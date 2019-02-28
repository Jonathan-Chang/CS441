//
//  GameScene.swift
//  p3_animation
//
//  Created by Jonathan on 2/17/19.
//  Copyright © 2019 Jonathan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var score = 0
    var lives = 3
    var livesSprite1 = SKSpriteNode(imageNamed: "ironmanlives")
    var livesSprite2 = SKSpriteNode(imageNamed: "ironmanlives")
    var livesSprite3 = SKSpriteNode(imageNamed: "ironmanlives")
    
    let scoreLabel = SKLabelNode(text: "")
    
    let ironMan = SKSpriteNode(imageNamed: "ironman")
    
    enum state{
        case pre
        case ing
        case after
    }
    
    var currState = state.ing
    
    
    struct PhysicsCat{
        static let None: UInt32 = 0
        static let IronMan: UInt32 = 0b1 // 1
        static let Laser: UInt32 = 0b10
        static let Enemy: UInt32 = 0b100
    }
    
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
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
        
        
        self.addChild(ironMan)
        
        
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.15, y:self.size.height*0.9)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        
        
        livesSprite1.setScale(3)
        livesSprite1.zPosition = 100
        livesSprite1.position = CGPoint(x: self.size.width*0.75, y: self.size.height * 0.9)
        
        livesSprite2.setScale(3)
        livesSprite2.zPosition = 100
        livesSprite2.position = CGPoint(x: self.size.width*0.80, y: self.size.height * 0.9)
        
        livesSprite3.setScale(3)
        livesSprite3.zPosition = 100
        livesSprite3.position = CGPoint(x: self.size.width*0.85, y: self.size.height * 0.9)
        self.addChild(livesSprite1)
        self.addChild(livesSprite2)
        self.addChild(livesSprite3)
        
        
        startLevel()
    }
    
    func loseLife(){
        lives -= 1
        if lives == 2{
            livesSprite1.removeFromParent()
        }
        if lives == 1{
            livesSprite2.removeFromParent()
        }
        if lives == 0{
            livesSprite3.removeFromParent()
        }
        if lives == -1{
            gameOver()
        }
        
    }
    
    func gameOver(){
        currState = state.after
        
        self.removeAllActions()
        self.enumerateChildNodes(withName: "Laser"){
            laser, stop in
            laser.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "Enemy"){
            enemy, stop in
            enemy.removeAllActions()
        }
        
        
        
    }
    
    
    func incrementScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        //if score == 100 { do something }
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bod1 = SKPhysicsBody()
        var bod2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            bod1 = contact.bodyA
            bod2 = contact.bodyB
        }
        else{
            bod1 = contact.bodyB
            bod2 = contact.bodyA
        }
        
        if bod1.categoryBitMask == PhysicsCat.IronMan && bod2.categoryBitMask == PhysicsCat.Enemy{
            
            loseLife()
            if(bod1.node != nil){
                spawnExplode(spawnPosition: bod1.node!.position)
            }
            if (bod2.node != nil){
                spawnExplode(spawnPosition: bod2.node!.position)
            }
            
            bod2.node?.removeFromParent()
            
        }
        
        if bod1.categoryBitMask == PhysicsCat.Laser && bod2.categoryBitMask == PhysicsCat.Enemy{
            
            incrementScore()
            if bod2.node != nil{
                if bod2.node!.position.y > self.size.height{
                    return
                }
                else{
                    spawnExplode(spawnPosition: bod2.node!.position)
                    
                }
            }
            
            bod1.node?.removeFromParent()
            bod2.node?.removeFromParent()
            
            
        }
        
        
        
    }
    
    
    func spawnExplode(spawnPosition: CGPoint){
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let deleteExplosion = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([scaleIn, fadeOut,deleteExplosion])
        explosion.run(explosionSequence)
    }
    
    
    func startLevel(){
        let spawn = SKAction.run(enemySpawn)
        let waitSpawn = SKAction.wait(forDuration: 3)
        let spawnSequence = SKAction.sequence([spawn, waitSpawn])
        let spawning = SKAction.repeatForever(spawnSequence)
        self.run(spawning)
        
        
    }
    
    
    
    func fireIron(){
        let laser = SKSpriteNode(imageNamed: "ironmanblast")
        laser.name = "Laser"
        laser.setScale(1)
        laser.position = ironMan.position
        laser.zPosition = 1
        laser.physicsBody = SKPhysicsBody(rectangleOf: laser.size)
        laser.physicsBody!.affectedByGravity = false
        laser.physicsBody!.categoryBitMask = PhysicsCat.Laser
        
        laser.physicsBody!.collisionBitMask = PhysicsCat.None
        laser.physicsBody!.contactTestBitMask = PhysicsCat.Enemy
        
        
        self.addChild(laser)
        
        let moveLaser = SKAction.moveTo(y: self.size.height + laser.size.height , duration: 1)
        let deleteLaser = SKAction.removeFromParent()
    
        let laserSequence = SKAction.sequence([moveLaser, deleteLaser])
        laser.run(laserSequence)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currState == state.ing{
        
            fireIron()
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let previousTouch = touch.previousLocation(in: self)
            let amtDrag = pointOfTouch.x - previousTouch.x
            
            if(currState == state.ing){
                ironMan.position.x += amtDrag
            }
            
            if ironMan.position.x > gameRect.maxX - ironMan.size.width/2{
                ironMan.position.x = gameRect.maxX - ironMan.size.width/2
            }
            
            if ironMan.position.x < gameRect.minX + ironMan.size.width/2{
                ironMan.position.x = gameRect.minX + ironMan.size.width/2
            }
            
        }
    }
    
    func enemySpawn(){
        let randXStart = random(min: gameRect.minX, max: gameRect.maxX)
        let randXEnd = random(min: gameRect.minX, max: gameRect.maxX)
        
        let startPoint = CGPoint(x: randXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randXEnd, y: -self.size.height * 1.2)
        
        let enemy = SKSpriteNode(imageNamed: "alien")
        enemy.name = "Enemy"
        enemy.setScale(2)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCat.Enemy
        //Physics body of enemy dont wan't it to collide
        //But we want it to make contact w/ ironman and laser
        enemy.physicsBody!.collisionBitMask = PhysicsCat.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCat.IronMan | PhysicsCat.Laser
        
        
        
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALife = SKAction.run(loseLife)
        let enemySequence = SKAction.sequence([moveEnemy,deleteEnemy, loseALife])
        
        if currState == state.ing{
            enemy.run(enemySequence)
        }
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountRotate = atan2(dy, dx)
        enemy.zRotation = amountRotate
        
        
    }
    
    
    
    
}
