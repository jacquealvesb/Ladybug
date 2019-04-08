//: [Previous](@previous)

import PlaygroundSupport
import SpriteKit
import AVFoundation

class SubroutineBook: SKScene {
    
    var barSprite: SKSpriteNode!
    var helpLabel: SKLabelNode!
    let cardPosition = CGPoint(x: 0, y: -350)
    var difference: CGPoint = CGPoint.zero
    let maxCards: CGFloat = 10.0
    var yScaleToAdd: CGFloat = 0.0
    var movingObject: Object?
    var started = false
    var ended = false
    
    var correctSound: AVAudioPlayer?
    var wrongSound: AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        
        let correctSoundFile = URL(fileURLWithPath: Bundle.main.path(forResource: "correctSound", ofType: "wav")!)
        
        do {
            correctSound = try AVAudioPlayer(contentsOf: correctSoundFile)
        } catch {
            print("error")
        }
        
        let wrongSoundFile = URL(fileURLWithPath: Bundle.main.path(forResource: "wrongSound", ofType: "wav")!)
        
        do {
            wrongSound = try AVAudioPlayer(contentsOf: wrongSoundFile)
        } catch {
            print("error")
        }
        
        barSprite = childNode(withName: "barSprite") as? SKSpriteNode
        helpLabel = childNode(withName: "helpLabel") as? SKLabelNode
        
        yScaleToAdd = 1.0/maxCards
        barSprite.yScale = 0
        helpLabel.text = "So she and her colleagues started filling\nnotebooks with bits of tried-and-tested,\nre-useable code. Try helping them"
        
        let object1 = Object()
        let object2 = Object()
        
        object1.position = cardPosition
        object2.position = cardPosition
        
        addChild(object1)
        addChild(object2)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(start), userInfo: nil, repeats: false)
    }
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    @objc func start() {
        started = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!started || ended) {
            return
        }
        
        /*:
         
             # Card movement
         
             Here we check if the player has touched a card, making it moves with the mouse untill the player stops touching the screen
         
         */
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if let object = touchedNode as? Object {
                difference = CGPoint(x: location.x - object.position.x, y: location.y - object.position.y)
                
                object.zPosition = 5
                object.moving = true
                movingObject = object
            }
        }
        
        if(helpLabel.alpha > 0) {
            helpLabel.run(.fadeOut(withDuration: 1))
        }
    }
    
    /*:
        This makes the current moving object follow the user's finger ou mouse
     
    */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let object = movingObject {
                object.position.x = location.x - difference.x
                object.position.y = location.y - difference.y
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(ended){
            return
        }
        
        /*:
         
             Here we check if the player has dropped the card on the left or right side of the screen, verifying if it was the correct side to put it
         
         */
        
        if let object = movingObject {
            let newObject = Object()
            newObject.position = cardPosition
            
            insertChild(newObject, at: 1)
            object.removeFromParent()
            
            if((object.correct && object.position.x > 0) || (!object.correct && object.position.x < 0)) {
            
                if(object.correct) {
                    barSprite.yScale += yScaleToAdd
                    stopSound(correctSound)
                    playSound(correctSound)
                    
                    /*:
                     
                         Here we check if all cards have been put on the book
                     
                     */
                    
                    if(barSprite.yScale >= 1) {
                        ended = true
                        
                        for obj in children {
                            if obj is Object {
                                obj.removeFromParent()
                            }
                        }
                        
                        helpLabel.text = "Great job!"
                        
                        helpLabel.run(.fadeIn(withDuration: 1))
                    }
                }
                
            } else {
                print("errou")
                playSound(wrongSound)
            }
        }
    
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
if let scene = SubroutineBook(fileNamed: "SubroutineBook") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView


//: [Next](@next)
