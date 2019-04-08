
/*:
  
 ![Playground Icon](icon.png width="467" height="250")
 
 ### About
 
 Ladybug is an interactive story about Grace Hopper, a U.S. marine and computer scientist who had a great impact on the world of computing and pionering ideas that led us to where we are today, making computing more accessible and computers more useful.
 
 * Callout(Purpose):
Since the beginning my goal was to tell the story of one of the many women that were important to the world of computing. Their stories are not told very often, but it’s very important that we tell them, mainly to young girls, so that they can see themselves and all the possibilities they can have on all kinds of work fields.
 I ended up knowing the stories of a lot of amazing women that I didn’t know before, and choosing one of them was very hard, but I decided to go with Grace Hopper because I believe that the things she invented and the ideias she had led to things that are nowadays known for many people, even if they don’t work with computing.
 
 
 ### Requirements
 
 You may use Ladybug in the latest release of Swift Playgrounds (2.2).

 *Please, lock iPad's orientation and use in full screen (hiding code) for a better experience.*
 
 
 ### Credits
 
 The sounds were obtained at www.freesound.org.
 
 The information about Grace was obtained at www.ada.vc and www.bbc.com.
 
 */
import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = SKScene(fileNamed: "StartScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//: [Next](@next)
