
import SpriteKit

public class Bar: SKSpriteNode{
    var barValue: Double!
    var barView: SKSpriteNode!
    var barLabel: SKLabelNode!
    
    public init(barLabelText: String, barValue: Double, barColor: UIColor, positionX: Int, size: CGSize) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        self.barValue = barValue
        barLabel = SKLabelNode(text: barLabelText)
        barLabel.horizontalAlignmentMode = .right
        barLabel.position = CGPoint(x: size.width / 10, y: (size.height / 1.25) - CGFloat(positionX))
        barLabel.setScale(0.9)
        
        barView = SKSpriteNode(color: barColor, size: CGSize(width: self.barValue * 1.5, height: 30))
        barView.anchorPoint = CGPoint(x: 0, y: 1)
        barView.position = CGPoint(x: size.width / 9, y: (size.height / 1.22) - CGFloat(positionX))
        
        addChild(barLabel)
        addChild(barView)
        
    }
    
    func updateBar(value: Double) {
        self.barValue = value
        if(self.barValue > 100) {
            self.barValue = 100
        }else if(self.barValue < 0){
            self.barValue = 0
        }
        if(self.barValue >= 0) {
            barView.run(.resize(toWidth: CGFloat(self.barValue * 1.5), duration: 0.1))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

