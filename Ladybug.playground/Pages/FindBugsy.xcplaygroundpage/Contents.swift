//: [Previous](@previous)

import PlaygroundSupport
import SpriteKit

class FindBugsyScene: SKScene {
    
    var bugsyBaloonSprite: SKSpriteNode!
    var ladybugSprite: SKSpriteNode!
    var spotSprite: SKSpriteNode!
    
    var canGetLadybug = false
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        bugsyBaloonSprite = childNode(withName: "//bugsyBaloon") as? SKSpriteNode
        ladybugSprite = childNode(withName: "//ladybugSprite") as? SKSpriteNode
        spotSprite = childNode(withName: "//spotSprite") as? SKSpriteNode
        
        ladybugSprite.name = "ladybug"
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(start), userInfo: nil, repeats: false)
    }
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    @objc func start() {
        canGetLadybug = true
        let increase = SKAction.scale(by: 2, duration: 0.5)
        let decrease = SKAction.scale(by: 0, duration: 0.5)
        let sequence = SKAction.sequence([increase, decrease])
        
        spotSprite.run(.repeatForever(sequence))
        
    }
    
    /*:
     
     Here we detect if the player touched the ladybug node, making it move till it gets to Grace's node.
     
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchLocation)
            
            if let name = touchedNode.name {
                if (canGetLadybug && name == "ladybug") {
                    canGetLadybug = false
                    spotSprite.removeAllActions()
                    
                    bugsyBaloonSprite.run(.fadeOut(withDuration: 1))
                    ladybugSprite.run(.move(to: CGPoint(x: -126, y: -408), duration: 3))
                }
            }
        }
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = FindBugsyScene(fileNamed: "FindBugsyScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//: [Next](@next)
