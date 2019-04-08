//: [Previous](@previous)

/*:
 
 A lot of times, the Mark 1 would grind to a halt soon after starting - and there was no user-friendly error message.
 
 Once, it was because a moth had flown into the machine - that gave us the term "bug", indicating an error on the code, and "debugging", correcting it.
 
 But most of the time, the bug was metaphorical - a wrongly flipped switch, a mispunched hole in the paper tape.
 
 */

import PlaygroundSupport
import SpriteKit
import AVFoundation

class MarkIScene: SKScene {
    
    var bugsySprite: SKSpriteNode!
    var bugsyBaloonSprite: SKSpriteNode!
    var bugsyLabel: SKLabelNode!
    
    var bugWingsSound: AVAudioPlayer?
    
    var started = false
    
    override func didMove(to view: SKView) {
        let bugWingsSoundFile = URL(fileURLWithPath: Bundle.main.path(forResource: "bugWingsSound", ofType: "wav")!)
        
        do {
            bugWingsSound = try AVAudioPlayer(contentsOf: bugWingsSoundFile)
        } catch {
            print("error")
        }
        
        bugsySprite = childNode(withName: "//bugsySprite") as? SKSpriteNode
        bugsyBaloonSprite = childNode(withName: "//bugsyBaloonSprite") as? SKSpriteNode
        bugsyLabel = childNode(withName: "//bugsyLabel") as? SKLabelNode
        
        bugsySprite.name = "bugsy"
        bugsyLabel.text = "Oh, it's a bug...\nTake it off!"
        
        Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(start), userInfo: nil, repeats: false)
        
        self.becomeFirstResponder()
    }
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    @objc func start() {
        started = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = nodes(at: location).first!
            
            if let name = touchedNode.name, name == "bugsy" {
                bugsyFly()
            }
        }
    }
    
    /*:
     
        Here we set the ladybug animation, making its textures change and moving it away from the screen.
     
     */
    func bugsyFly() {
        let bugsyFlyTextures = [SKTexture(imageNamed: "bugsy_fly_1"), SKTexture(imageNamed: "bugsy_fly_2")]
        let bugsyTextureAnimation = SKAction.animate(with: bugsyFlyTextures, timePerFrame: 0.3)
        let bugsyFlyPosition = SKAction.sequence([.move(to: CGPoint(x: 916, y: 292), duration: 2),
                                                  .move(to: CGPoint(x: 1240, y: 745), duration: 2)])
        
        bugsySprite.xScale = -1
        bugsySprite.run(.repeatForever(bugsyTextureAnimation))
        bugsySprite.run(bugsyFlyPosition) {
            self.stopSound(self.bugWingsSound)
            self.bugsySprite.removeFromParent()
        }
        
        bugsyLabel.text = "Wait...Bugsy?!"
        bugsyBaloonSprite.run(.fadeIn(withDuration: 1))
        
        playSound(bugWingsSound)
    }
    
    func playSound(_ sound: AVAudioPlayer?) {
        if let sound = sound {
            sound.prepareToPlay()
            sound.play()
        }
    }
    
    func stopSound(_ sound: AVAudioPlayer?) {
        if let sound = sound {
            sound.stop()
            
        }
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = MarkIScene(fileNamed: "MarkIScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//: [Next](@next)
