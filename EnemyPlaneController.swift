//
//  EnemyPlaneController.swift
//  Session1
//
//  Created by Admin on 9/22/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class EnemyPlaneController : Controller {
    //    let SHOT_DURATION = 0.5
    let SPEED : Double = 100
    let SHOT_DURATION = 1.0
    
    override func setup(parent : SKNode) -> Void {
        addFlyAction(parent)
        addShotAction(parent)
        configurePhysics() 
    }
    
    func configurePhysics() -> Void {
        //1
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        //2
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_ENEMY
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_BULLET | PHYSICS_MASK_PLAYER
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
        let bulletView = View(imageNamed: "bullet.png")
        
        // 2
        bulletView.position = view.position.subtract(
            CGPoint(x: 0, y: view.frame.height / 2 +
                bulletView.frame.height / 2 + 10)
        )
        
        // 3
        
        let bulletEnemyController = BulletEnemyController(view: bulletView)
        
        bulletEnemyController.setup(parent)
        
        parent.addChild(bulletView)
        
    }
    
    
    func addFlyAction(parent : SKNode) -> Void {
        let distanceToFloor =  Double (self.view.position.y)
        print("distanceToFloor : \(distanceToFloor)")
        
        let timeToReachFloor = distanceToFloor / SPEED
        
        self.view.runAction(
            SKAction.sequence([
                SKAction.moveToY(0, duration: timeToReachFloor),
                SKAction.removeFromParent()
                ])
        )
    }
}
