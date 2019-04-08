import SpriteKit

public class Object : SKSpriteNode {
    public var moving: Bool
    public var attached: Bool
    public var initialPosition: CGPoint
    
    public override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.moving = false
        self.attached = false
        self.initialPosition = CGPoint.zero
        
        super.init(texture: texture, color: color, size: size)
        
        self.initialPosition = self.position
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public init(resourceName: String, withName name: String, at position: CGPoint) {
        self.moving = false
        self.attached = false
        self.initialPosition = position
        
        let texture = SKTexture(imageNamed: resourceName)

        super.init(texture: texture, color: .white, size: texture.size())
        
        self.position = position
        self.name = name
        
    }
}
