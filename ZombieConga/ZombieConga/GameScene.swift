//
//  GameScene.swift
//  ZombieConga
//
//  Created by Mitya Kim on 1/14/24.
//

import SpriteKit


class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
//        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint.zero
//        background.zRotation = CGFloat.pi / 4
        background.zPosition = -1
        scene?.addChild(background)
        
        let mySize = background.size
        print("Size: \(mySize)")
        
        let zombie = SKSpriteNode(imageNamed: "zombie1")
        zombie.position = CGPoint(x: 400, y: 400)
//        zombie.scale(to: CGSize(width: 200, height: 200))
        scene?.addChild(zombie)
        
    }
}
