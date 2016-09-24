//
//  GameScene.swift
//  Session1
//
//  Created by Apple on 8/28/16.
//  Copyright (c) 2016 TechKids. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Nodes
    //    var plane:SKSpriteNode!
    var playerPlaneController : PlayerPlaneController!
    //    var bulletController  : BulletController!
    //
    var lastUpdateTime : NSTimeInterval = -1
    
    // Counters
    var bulletIntervalCount = 0
    var enemyIntervalCount = 0
    
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        addEnemy()
        addPowerUp()
        addSimpleNode()
        configurePhysics()
    }
    
    func configurePhysics() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let maskA = bodyA.categoryBitMask
        let maskB = bodyB.categoryBitMask
        
        if (maskA | maskB == (PHYSICS_MASK_POWERUP | PHYSICS_MASK_PLAYER)) {
            if maskA ==  PHYSICS_MASK_POWERUP {
                bodyA.node?.removeFromParent()
            }
            else {
                bodyB.node?.removeFromParent()
            }
            playerPlaneController.changeBullet("pair_bullet.jpg")
        }
        else {
            if let emitter = SKEmitterNode(fileNamed: "MyParticle.sks"){
                
                emitter.position = (bodyA.node?.position)!
                
                addChild(emitter)
            }

            bodyA.node?.removeFromParent()
            bodyB.node?.removeFromParent()
        }
        
        
    }
    func didEndContact(contact: SKPhysicsContact) {
        print("didEndContact")
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        print("touches count: \(touches.count)")
        if let touch = touches.first {
            // 1
            let currentTouchPosition = touch.locationInNode(self)
            let previousTouchPosition = touch.previousLocationInNode(self)
            
            
            playerPlaneController.moveBy(currentTouchPosition.subtract(previousTouchPosition))
            
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        //        print("\(currentTime)")
        
        self.enumerateChildNodesWithName("enemy") {
            enemyNode, _ in
            self.enumerateChildNodesWithName("bullet") {
                bulletNode, _ in
                let bulletFrame = bulletNode.frame
                let enemyFrame = enemyNode.frame
                
                // 2
                if CGRectIntersectsRect(bulletFrame, enemyFrame) {
                    // 3
                    bulletNode.removeFromParent()
                    enemyNode.removeFromParent()
                    self.runAction(SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false))
                }
            }
        }
    }
    
    func addPowerUp() {
        let powerUp = View(imageNamed: "power_up.jpg");
        
        let diceRoll = Int(arc4random_uniform(UInt32 (self.frame.size.width)))
        
        powerUp.position = CGPoint(x: CGFloat (diceRoll) , y: self.frame.size.height)
        
        let powerUpController = PowerUpController(view: powerUp)
        
        powerUpController.setup(self)
        
        addChild(powerUp)
        
    }
    
    func addEnemy() {
        
        let enemySpawn = SKAction.runBlock {
            
            // 1
            let enemy = View(imageNamed: "plane1.png")
            
            // 2
            let diceRoll = Int(arc4random_uniform(UInt32 (self.frame.size.width)))
            
            enemy.position = CGPoint(x: CGFloat (diceRoll) , y: self.frame.size.height)
            
            // 3
            var textures : [SKTexture] = []
            let nameFormat = "enemy_plane_white_"
            for i in 1..<4 {
                let imageName = "\(nameFormat)\(i).png"
                let texture = SKTexture(imageNamed: imageName)
                textures.append(texture)
            }
            //
            let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.02)
            
            4
            //            let enemyFly = SKAction.moveByX(0, y: -20, duration: 0.2)
            //
            //            enemy.runAction(SKAction
            //                .repeatActionForever(enemyFly))
            enemy.runAction(SKAction.repeatActionForever(animate))
            //            // 5
            let enemyPlaneController = EnemyPlaneController(view: enemy)
            
            enemyPlaneController.setup(self)
            
            self.addChild(enemy)
            
            // 6
            //            enemy.name = "enemy"
        }
        //
        let enemySpawnPeriod = SKAction.sequence([enemySpawn, SKAction.waitForDuration(2.5)])
        
        let enemySpawnPeriodForever = SKAction.repeatActionForever(enemySpawnPeriod)
        
        self.runAction(enemySpawnPeriodForever)
    }
    
    
    func addBackground() {
        // 1
        let background = SKSpriteNode(imageNamed: "background.png")
        
        // 2
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        
        // 3
        addChild(background)
    }
    
    func addPlane() {
        
        
        // 1
        let planeView = View(imageNamed: "plane3.png")
        
        // 2
        planeView.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
        
        self.playerPlaneController = PlayerPlaneController(view : planeView)
        
        self.playerPlaneController.setup(self)
        //        // 3
        //        let playSound = SKAction.playSoundFileNamed("laser_shot.wav", waitForCompletion: false)
        //        let shot = SKAction.runBlock {
        //            self.addBullet()
        //        }
        //
        //        let periodShot = SKAction.sequence([shot,
        //            playSound, SKAction.waitForDuration(0.1)])
        //        let shotForever = SKAction.repeatActionForever(periodShot)
        //
        //        // 4
        //        plane.runAction(shotForever)
        //
        // 5
        addChild(planeView)
    }
    
    func addSimpleNode() {
        let simpleNode = SKLabelNode(text: "O")
        simpleNode.name = "simple"
        simpleNode.position = CGPoint(x: 10, y: 10)
        addChild(simpleNode)
    }
}
