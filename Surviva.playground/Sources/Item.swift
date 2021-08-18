
import SpriteKit

class Item: SKSpriteNode {
//      var itemView: UIImage
    var itemView: SKSpriteNode!
    var itemList: [UIImage] = []
    var sizeFrame: CGSize!
    var categoryBitMask: UInt32!
    init(itemList: [UIImage], sizeFrame: CGSize, categoryBitMask: UInt32) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        self.itemList = itemList
        self.sizeFrame = sizeFrame
        self.categoryBitMask = categoryBitMask
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func doSomething() {}
    
    private func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    private func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addItem() {
        let assetRandom = random(min: 0, max: CGFloat(itemList .count - 1))
        itemView = SKSpriteNode(texture: SKTexture(image: itemList[Int(assetRandom)]), size: CGSize(width: sizeFrame.width * 0.05, height: sizeFrame.width * 0.05))
        let itemPlacementX = random(min: 0, max: sizeFrame.width)
        
        itemView.position = CGPoint(x: itemPlacementX, y: sizeFrame.height + 100)
        
        itemView.physicsBody = SKPhysicsBody(rectangleOf: itemView.size) // 1
        itemView.physicsBody?.collisionBitMask = categoryBitMask
        itemView.physicsBody?.isDynamic = true // 2
        itemView.physicsBody?.categoryBitMask = categoryBitMask // 3
        itemView.physicsBody?.contactTestBitMask = PhysicsCategory.playerObject
        
        addChild(itemView)
        
        let itemSpeed = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let itemMove = SKAction.move(to: CGPoint(x: itemPlacementX, y: itemView.size.height/2),duration: TimeInterval(itemSpeed))
        let itemMoveDone = SKAction.removeFromParent()
        itemView.run(SKAction.sequence([itemMove, itemMoveDone]))
    }
    
    func removeItem() {
        itemView.removeFromParent()
    }
}
