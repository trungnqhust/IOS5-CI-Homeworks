//
//  PowerUpController.swift
//  Session1
//
//  Created by Admin on 9/24/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

class PowerUpController : Controller {
    let SPEED = 30.0
    
    override func setup(parent : SKNode) -> Void {
        addFlyAction(parent)
        configurePhysics()
    }
    
    func configurePhysics() -> Void {
        //1
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        //2
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_POWERUP
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER
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
