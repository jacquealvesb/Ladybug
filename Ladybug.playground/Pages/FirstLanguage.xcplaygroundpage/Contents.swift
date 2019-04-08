//: [Previous](@previous)

/*:
 
 Kurt Beyer's book, "Grace Hopper and the Invention of the Information Age", relates many tales of impressed users of Grace's subroutines book.
 
 One of them was an engineer called Carl Hammer, who used the compiler to attack an equation his colleagues had struggled with for months.
 
 Mr Hammer wrote 20 lines of code, and solved it in a day.
 
 */

import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = SKScene(fileNamed: "FirstLanguageScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//: [Next](@next)
