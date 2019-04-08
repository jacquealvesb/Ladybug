//: [Previous](@previous)

import PlaygroundSupport
import SpriteKit
import AVFoundation

class TrophiesScene: SKScene {
    
    var labels = [SKNode]()
    var positions = [CGPoint(x: -290, y: -420),
                     CGPoint(x: -100, y: -420),
                     CGPoint(x: 100, y: -420),
                     CGPoint(x: 290, y: -420)]
    var attached = 0
    var currentLabel = 0
    var waitLable = false
    var started = false
    var movingObject: Object?
    
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
        /*:
             Here we create all objcts that we have to find th shadow
         
         */
        
        started = true
        
        for i in 0..<4 {
            if let node = childNode(withName: "//labels_\(i)") {
                labels.append(node)
            }
            
            let object = Object(resourceName: "\(i)", withName: "\(i)", at: positions[i])
            
            insertChild(object, at: 1)
            object.setScale(0.4)

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!started || waitLable) {
            return
        }
        
        
        /*:
         
             # Object movement
         
             Here we check if the player has touched an object, making it moves with the mouse untill the player stops touching the screen
         
         */
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if let object = touchedNode as? Object, object.attached == false {
                object.moving = true
                object.zPosition = 3
                movingObject = object
            }
        }
    }
    
    /*:
     
        This makes the current moving object follow the user's finger ou mouse
     
    */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!started || waitLable) {
            return
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if let object = movingObject {
                object.position.x = location.x
                object.position.y = location.y
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!started) {
            return
        }
        
        if(waitLable) {
            let label = childNode(withName: "label_\(currentLabel)")!

            label.removeAllActions()
            label.run(.fadeOut(withDuration: 1)) {
                self.waitLable = false
            }
            
        } else {
            /*:
             
             Here we check if the player has dropped the card on the left or right side of the screen, verifying if it was the correct side to put it
             
             */
            
            if let object = movingObject {
                let shadow = childNode(withName: "\(object.name!)_shadow")
                
                object.moving = false
                movingObject = nil
                
                if let shadow = shadow {
                    if (object.intersects(shadow)) {
                        playSound(correctSound)
                        
                        object.setScale(0.7)
                        object.position = shadow.position
                        object.attached = true
                        
                        shadow.removeFromParent()
                        
                        if let objectNumber = Int(object.name!) {
                            let label = childNode(withName: "label_\(objectNumber)")!
                            let wait = SKAction.wait(forDuration: 10)
                            let fadeIn = SKAction.run {
                                label.run(.fadeIn(withDuration: 1))
                            }
                            let fadeOut = SKAction.run {
                                label.run(.fadeOut(withDuration: 1))
                            }
                            
                            waitLable = true
                            currentLabel = objectNumber
                            
                            run(SKAction.sequence([fadeIn, wait, fadeOut])) {
                                self.waitLable = false
                            }
                            labels[objectNumber].run(.fadeIn(withDuration: 1))
                        }
                        
                        attached += 1
                        
                        if(attached >= labels.count) {
                            print("fim")
                        }
                    } else {
                        object.position = object.initialPosition
                        playSound(wrongSound)
                        
                    }
                }
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
            sound.pause()
        }
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = TrophiesScene(fileNamed: "TrophiesScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView


//: [Next](@next)
