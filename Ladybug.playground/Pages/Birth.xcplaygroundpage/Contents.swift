//: [Previous](@previous)

import PlaygroundSupport
import SpriteKit
import AVFoundation

class BirthScene: SKScene {
    
    let texts = ["Grace Brewster Murray", "December 9th, 1906", "New York"]
    var labels = [SKLabelNode]()
    var counter = 0
    var currentText = 0
    var timer: Timer!
    var typewriterSound: AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        
        let typewriterSoundFile = URL(fileURLWithPath: Bundle.main.path(forResource: "typewriterSound", ofType: "wav")!)
        
        do {
            typewriterSound = try AVAudioPlayer(contentsOf: typewriterSoundFile)

        } catch {
            print("erro")
        }
        
        if let nameLabel = childNode(withName: "//nameLabel") as? SKLabelNode {
            nameLabel.text = ""
            labels.append(nameLabel)
        }
        
        if let yearLabel = childNode(withName: "//yearLabel") as? SKLabelNode {
            yearLabel.text = ""
            labels.append(yearLabel)
        }
        
        if let placeLabel = childNode(withName: "//placeLabel") as? SKLabelNode {
            placeLabel.text = ""
            labels.append(placeLabel)
        }
        
        /*:
         
             # Timer
         
             Here we set a timer that calls the function to write a letter with a delay of 0.3s
         
         */
        
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
    }
    
    
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    /*:
     
         # Typping letters
     
         We use this function to write the text letter by letter with a little random delay each time, simulating a typewritter.
     
     */
    
    @objc func typeLetter() {
        let text = texts[currentText]
        let label = labels[currentText]
        
        if(counter < text.count) {
            let index = text.index(text.startIndex, offsetBy: counter)
            
            label.text?.append(text[index])
            playSound(typewriterSound)
            
            let randomInterval = Double((arc4random_uniform(8)+1))/20
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
            
        } else {
            if(currentText < texts.count - 1) {
                currentText += 1
                counter = -1
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
            } else {
                timer.invalidate()

            }
        }
        
        counter += 1
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
if let scene = BirthScene(fileNamed: "BirthScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//: [Next](@next)
