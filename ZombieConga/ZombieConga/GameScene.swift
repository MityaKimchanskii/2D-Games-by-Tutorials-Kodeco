//
//  GameScene.swift
//  ZombieConga
//
//  Created by Mitya Kim on 1/14/24.
//

import SpriteKit


class GameScene: SKScene {
    
    var lastUpdaateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    
    let background = SKSpriteNode(imageNamed: "background1")
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    
    let playableRect: CGRect
    
    override init(size: CGSize) {
        let maxAspectRation: CGFloat = 16.0/9.0
        let playableHeight = size.width/maxAspectRation
        let playableMargin = (size.height - playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        
        //        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint.zero
        //        background.zRotation = CGFloat.pi / 4
        background.zPosition = -1
        scene?.addChild(background)
        
        //        let mySize = background.size
        //        print("Size: \(mySize)")
        
        
        zombie.position = CGPoint(x: 200, y: 400)
        //        zombie.scale(to: CGSize(width: 200, height: 200))
        scene?.addChild(zombie)
        
        debugDrawPlayableArea()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        if lastUpdaateTime > 0 {
            dt = currentTime - lastUpdaateTime
        } else {
            dt = 0
        }
        
        lastUpdaateTime = currentTime
        print("\(dt*1000) milliseconds since last update")
        
        move(sprite: zombie, velocity: velocity)
        
        boundsCheckZombie()
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        print("Amount to move: \(amountToMove)")
        
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    func moveZombieToward(location: CGPoint) {
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        
        let lenght = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        
        let direction = CGPoint(x: offset.x / CGFloat(lenght), y: offset.y / CGFloat(lenght))
        velocity = CGPoint(x: direction.x * zombieMovePointsPerSec, y: direction.y * zombieMovePointsPerSec)
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        moveZombieToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    func boundsCheckZombie() {
//        let bottomLeft = CGPoint.zero
//        let topRight = CGPoint(x: size.width, y: size.height)
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode(rect: playableRect)
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
}
