//: [Previous](@previous)

/*:
 
 Grace's goal was to free programmer's brainpower to think about concepts and algorithms, not switches and wires.
 
 She had her own views of why her colleagues had been initially resistant to her ideas: not because they cared about making programs run more quickly, but because they enjoyed the prestige of being the only ones who could communicate with the godlike computer.
 
 The "high priests", Grace called them.
 
 She thought anyone should be able to programme.
 
 */

import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = SKScene(fileNamed: "EveryoneCanScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
