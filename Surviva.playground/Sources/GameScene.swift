import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    var player: SKSpriteNode!
    var gameOverLabel: SKLabelNode!
    var playerCondition: [UIImage] = [#imageLiteral(resourceName: "grinning-face-with-big-eyes_1f603.png"),#imageLiteral(resourceName: "slightly-smiling-face_1f642.png"),#imageLiteral(resourceName: "face-with-thermometer_1f912.png"),#imageLiteral(resourceName: "dizzy-face_1f635.png")]
    
    var enemyObject: Item = Item(itemList: [#imageLiteral(resourceName: "busts-in-silhouette_1f465.png"),#imageLiteral(resourceName: "nauseated-face_1f922.png"),#imageLiteral(resourceName: "people-hugging_1fac2.png"),#imageLiteral(resourceName: "speaking-head_1f5e3-fe0f.png"),#imageLiteral(resourceName: "face-vomiting_1f92e.png"),#imageLiteral(resourceName: "sneezing-face_1f927.png")], sizeFrame: UIScreen.main.bounds.size, categoryBitMask: PhysicsCategory.itemEnemy)
    var killObject: Item = Item(itemList: [#imageLiteral(resourceName: "microbe_1f9a0.png")], sizeFrame: UIScreen.main.bounds.size, categoryBitMask: PhysicsCategory.itemDead)
    var immunityObject: Item = Item(itemList: [#imageLiteral(resourceName: "badminton_1f3f8.png"),#imageLiteral(resourceName: "basketball_1f3c0.png"),#imageLiteral(resourceName: "man-biking-light-skin-tone_1f6b4-1f3fb-200d-2642-fe0f.png"),#imageLiteral(resourceName: "soccer-ball_26bd.png"),#imageLiteral(resourceName: "volleyball_1f3d0.png")], sizeFrame: UIScreen.main.bounds.size, categoryBitMask: PhysicsCategory.itemSupportImmun)
    var funObject: Item = Item(itemList: [#imageLiteral(resourceName: "bowling_1f3b3.png"),#imageLiteral(resourceName: "guitar_1f3b8.png"),#imageLiteral(resourceName: "musical-keyboard_1f3b9.png"),#imageLiteral(resourceName: "video-game_1f3ae.png"),#imageLiteral(resourceName: "violin_1f3bb.png")], sizeFrame: UIScreen.main.bounds.size, categoryBitMask: PhysicsCategory.itemSupportFun)
    var healthObject: Item = Item(itemList: [#imageLiteral(resourceName: "1__#$!@%!#__cooked-rice_1f35a.png"),#imageLiteral(resourceName: "broccoli_1f966.png"),#imageLiteral(resourceName: "carrot_1f955.png"),#imageLiteral(resourceName: "leafy-green_1f96c.png"),#imageLiteral(resourceName: "red-apple_1f34e.png"),#imageLiteral(resourceName: "tangerine_1f34a.png")], sizeFrame: UIScreen.main.bounds.size, categoryBitMask: PhysicsCategory.itemSupportHealth)
    var doctorObject: Item = Item(itemList: [#imageLiteral(resourceName: "health-worker-light-skin-tone_1f9d1-1f3fb-200d-2695-fe0f.png")], sizeFrame: UIScreen.main.bounds.size, categoryBitMask: PhysicsCategory.itemFull)
    
    var funBar = Bar(barLabelText: "Fun", barValue: 100, barColor: UIColor.yellow, positionX: 0, size: UIScreen.main.bounds.size)
    var healthBar = Bar(barLabelText: "Health", barValue: 100, barColor: UIColor.red, positionX: 50, size: UIScreen.main.bounds.size)
    var immunBar = Bar(barLabelText: "Immune", barValue: 100, barColor: UIColor.blue, positionX: 100, size: UIScreen.main.bounds.size)
    
    var gameOver: Bool = false
    var movingPlayer: Bool = false
    var offset: CGPoint!
    var currentScore = 0
    
    public override func didMove(to view: SKView) {
        createPlayer()
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        //itemEnemy
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(enemyObject.addItem),
                SKAction.wait(forDuration: 2.0)
            ])
        ))
        //itemDead
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(killObject.addItem),
                SKAction.wait(forDuration: 8.0)
            ])
        ))
        //itemFull
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(doctorObject.addItem),
                SKAction.wait(forDuration: 7.0)
            ])
        ))
        //itemFun
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(funObject.addItem),
                SKAction.wait(forDuration: 2.0)
            ])
        ))
        //itemHealth
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(healthObject.addItem),
                SKAction.wait(forDuration: 2.0)
            ])
        ))
        //itemImmun
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(immunityObject.addItem),
                SKAction.wait(forDuration: 2.0)
            ])
        ))
        
        self.addChild(funBar)
        self.addChild(healthBar)
        self.addChild(immunBar)
        self.addChild(enemyObject)
        self.addChild(killObject)
        self.addChild(doctorObject)
        self.addChild(healthObject)
        self.addChild(funObject)
        self.addChild(immunityObject)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(updateBar),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
        
    }
    
    func createPlayer() {
        player = SKSpriteNode(texture: SKTexture(image: playerCondition[0]), color: .clear, size: CGSize(width: size.width * 0.05, height: size.width * 0.05))
        player.position = CGPoint(x: frame.width  / 2, y: frame.height / 2)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        
        player.physicsBody?.isDynamic = true // 2
        player.physicsBody?.collisionBitMask = PhysicsCategory.playerObject
        player.physicsBody?.categoryBitMask = PhysicsCategory.playerObject // 3
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.contactTestBitMask = PhysicsCategory.itemDead | PhysicsCategory.itemEnemy | PhysicsCategory.itemFull | PhysicsCategory.itemSupportFun | PhysicsCategory.itemSupportImmun | PhysicsCategory.itemSupportHealth
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(player)
        
    }
    
    func updateBar() {
        funBar.updateBar(value: funBar.barValue - 2)
        healthBar.updateBar(value: healthBar.barValue - 2)
        immunBar.updateBar(value: immunBar.barValue - 2)
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if(!gameOver) {
            if(21 ... 50 ~= funBar.barValue || 21 ... 50 ~= healthBar.barValue || 21 ... 50 ~= immunBar.barValue) {
                player.run(.setTexture(SKTexture(image: playerCondition[1])))
            } else if(1 ... 20 ~= funBar.barValue || 1 ... 20 ~= healthBar.barValue || 1 ... 20 ~= immunBar.barValue) {
                player.run(.setTexture(SKTexture(image: playerCondition[2])))
            } else if(funBar.barValue <= 0 || healthBar.barValue <= 0 || immunBar.barValue == 0){
                player.run(.setTexture(SKTexture(image: playerCondition[3])))
                showGameOver()
            } else {
                player.run(.setTexture(SKTexture(image: playerCondition[0])))
            }
        }
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver else {
            return
        }
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        let touchNodes = nodes(at: touchLocation)
        for node in touchNodes {
            if node == player {
                movingPlayer = true
                offset = CGPoint(x: touchLocation.x - player.position.x, y: touchLocation.y - player.position.y)
            }
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        var playerObject: SKPhysicsBody
        var itemObject: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            playerObject = contact.bodyA
            itemObject = contact.bodyB
        } else {
            playerObject = contact.bodyB
            itemObject = contact.bodyA
        }
        
        // detect enemyItem
        if ((playerObject.categoryBitMask & PhysicsCategory.playerObject != 0) &&
                (itemObject.categoryBitMask & PhysicsCategory.itemEnemy != 0)) {
            if let itemNode = playerObject.node as? SKSpriteNode,
               let playerNode = itemObject.node as? SKSpriteNode {
                healthBar.updateBar(value: healthBar.barValue - 10)
                funBar.updateBar(value: funBar.barValue - 10)
                immunBar.updateBar(value: immunBar.barValue - 10)
                enemyObject.removeItem()
            }
        }
        
        // detect deadItem
        if ((playerObject.categoryBitMask & PhysicsCategory.playerObject != 0) &&
                (itemObject.categoryBitMask & PhysicsCategory.itemDead != 0)) {
            if let itemNode = playerObject.node as? SKSpriteNode,
               let playerNode = itemObject.node as? SKSpriteNode {
                healthBar.updateBar(value: healthBar.barValue - 50)
                funBar.updateBar(value: funBar.barValue - 50)
                immunBar.updateBar(value: immunBar.barValue - 50)
                killObject.removeItem()
            }
        }
        
        // detect deadItem
        if ((playerObject.categoryBitMask & PhysicsCategory.playerObject != 0) &&
                (itemObject.categoryBitMask & PhysicsCategory.itemFull != 0)) {
            if let itemNode = playerObject.node as? SKSpriteNode,
               let playerNode = itemObject.node as? SKSpriteNode {
                healthBar.updateBar(value: 100)
                funBar.updateBar(value: 100)
                immunBar.updateBar(value: 100)
                doctorObject.removeItem()
            }
        }
        
        // detect funItem
        if ((playerObject.categoryBitMask & PhysicsCategory.playerObject != 0) &&
                (itemObject.categoryBitMask & PhysicsCategory.itemSupportFun != 0)) {
            if let itemNode = playerObject.node as? SKSpriteNode,
               let playerNode = itemObject.node as? SKSpriteNode {
                funBar.updateBar(value: funBar.barValue + 10)
                funObject.removeItem()
            }
        }
        
        // detect imunItem
        if ((playerObject.categoryBitMask & PhysicsCategory.playerObject != 0) &&
                (itemObject.categoryBitMask & PhysicsCategory.itemSupportImmun != 0)) {
            if let itemNode = playerObject.node as? SKSpriteNode,
               let playerNode = itemObject.node as? SKSpriteNode {
                immunBar.updateBar(value: immunBar.barValue + 10)
                immunityObject.removeItem()
            }
        }
        
        // detect healthItem
        if ((playerObject.categoryBitMask & PhysicsCategory.playerObject != 0) &&
                (itemObject.categoryBitMask & PhysicsCategory.itemSupportHealth != 0)) {
            if let itemNode = playerObject.node as? SKSpriteNode,
               let playerNode = itemObject.node as? SKSpriteNode {
                healthBar.updateBar(value: healthBar.barValue + 10)
                healthObject.removeItem()
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver && movingPlayer else {return}
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        if(touchLocation.x < size.width) {
            let newPositionPlayer = CGPoint(x: touchLocation.x - offset.x, y: touchLocation.y - offset.y)
            player.run(SKAction.move(to: newPositionPlayer, duration: 0.01))
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingPlayer = false
    }
    
    func showGameOver() {
        gameOverLabel = SKLabelNode(text: "YOUR PROTECTION IS LOW. YOU'RE POSITIVE CORONAVIRUS")
        gameOverLabel.fontSize = 34
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.fontColor = UIColor.red
        gameOverLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameOverLabel)
        gameOver = true
    }
}
