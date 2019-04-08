import SpriteKit

public class Object : SKSpriteNode {
    public var moving: Bool
    public var correct: Bool
    
    public override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.moving = false
        self.correct = (Int.random(in: 0..<2) == 0)
        
        super.init(texture: texture, color: color, size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public init() {
        self.moving = false
        self.correct = (Int.random(in: 0..<2) == 0)
    
        var texture: SKTexture!
        let randomTexture = Int.random(in: 1..<3)
        
        if(self.correct) {
            texture = SKTexture(imageNamed: "card_\(randomTexture)")
        } else {
            texture = SKTexture(imageNamed: "card_\(randomTexture + 2)")
        }

        super.init(texture: texture, color: .white, size: CGSize(width: 375, height: 214))
        
        self.name = name
        
    }
}
