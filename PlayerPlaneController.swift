//
//  PlayerPlaneController.swift
//  Session1
//
//  Created by Admin on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class PlayerPlaneController : Controller{
    let SHOT_DURATION = 0.2
    var bulletViewName = "bullet.png"
    
    override func setup(parent : SKNode) -> Void {
        addShotAction(parent)
        configurePhysics() 
    }
    
    func changeBullet(bulletViewName : String) {
        self.bulletViewName = bulletViewName
    }
    
    func configurePhysics() -> Void {
        //1
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        //2
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY | PHYSICS_MASK_ENEMY_BULLET | PHYSICS_MASK_POWERUP
    }
    
    private func addShotAction(parent : SKNode) -> Void {
        self.view.runAction(
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.runBlock{ self.addBullet(parent)},
                    SKAction.waitForDuration(SHOT_DURATION)
                    ]
                )
            )
        )
    }
    private func addBullet(parent : SKNode) {
        // 1
        var bulletView = View(imageNamed: bulletViewName)
        
        // 2
        bulletView.position = view.position.add(
            CGPoint(x: 0, y: view.frame.height / 2 +
                bulletView.frame.height / 2 + 10)
        )
        
        // 3
        
        let bulletController = BulletController(view: bulletView)
        
        bulletController.setup(parent)
        
        parent.addChild(bulletView)
        //
        //        // 4
        //        let bulletFly = SKAction.moveByX(0, y: 30, duration: 0.1)
        //
        //        // 5
        //        bullet.runAction(SKAction.repeatActionForever(bulletFly))
        //
        //        // 5
        //        bullet.name = "bullet"
    }
    
}
