//: [Previous](@previous)

import PlaygroundSupport
import SpriteKit
import AVFoundation

class MathClassScene: SKScene {
    var calculationView: UIView!
    var firstNumberLabel: UILabel!
    var operationLabel: UILabel!
    var secondNumberLabel: UILabel!
    var equalLabel: UILabel!
    var textField: UITextField!
    var interactionsNode: SKNode!
    
    var correctSound: AVAudioPlayer?
    var wrongSound: AVAudioPlayer?
    
    let width = 50.0
    let height = 50.0
    
    let calculations = [Calculation(first: 2, second: 5, operation: .sum, emptyField: 1),
                        Calculation(first: 9, second: 4, operation: .subtration, emptyField: 3),
                        Calculation(first: 3, second: 4, operation: .multiplication, emptyField: 2),
                        Calculation(first: 20, second: 5, operation: .division, emptyField: 1)]
    var currentCalculation = 0
    
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
        
        interactionsNode = childNode(withName: "interaction")
        calculationView = UIView(frame: CGRect(x: 0, y: 0, width: width*5, height: height))
        
        firstNumberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        operationLabel = UILabel(frame: CGRect(x: width, y: 0, width: width, height: height))
        secondNumberLabel = UILabel(frame: CGRect(x: width*2, y: 0, width: width, height: height))
        equalLabel = UILabel(frame: CGRect(x: width*3, y: 0, width: width, height: height))
        textField = UITextField(frame: CGRect(x: width*4, y: 0.1*height, width: width*0.8, height: height*0.8))
        
        equalLabel.text = "="
        textField.borderStyle = .roundedRect
        textField.placeholder = "?"
        textField.textAlignment = .center
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(checkInput), for: .editingDidEnd)
        
        calculationView.addSubview(self.firstNumberLabel)
        calculationView.addSubview(self.operationLabel)
        calculationView.addSubview(self.secondNumberLabel)
        calculationView.addSubview(self.equalLabel)
        calculationView.addSubview(self.textField)
        
        for sv in self.calculationView.subviews {
            if let label = sv as? UILabel {
                label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            }
        }
        
        calculationView.center = CGPoint(x: self.view!.frame.width/2, y: self.view!.frame.height/8)
        calculationView.isHidden = true
        
        self.view?.addSubview(self.calculationView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        Timer.scheduledTimer(timeInterval: 12, target: self, selector: #selector(start), userInfo: nil, repeats: false)
    }
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    @objc func start() {
        if let node = childNode(withName: "//introduction") {
            node.removeFromParent()
        }
        
        calculationView.isHidden = false
        showCalculation(self.calculations[0])
    }
    
    /*:
     
     # Calculation interface
     
     On this function we receice an object of type Calculation, that holds the information of each operand, the operator, the result and which of the numbers is going to be filled.
     
     */
    
    func showCalculation(_ calculation: Calculation) {
        
        switch (calculation.emptyField) {
        case 1:
            textField.frame.origin = CGPoint(x: 0, y: 0.1*height)
            firstNumberLabel.frame.origin = CGPoint(x: 2*width, y: 0)
            secondNumberLabel.frame.origin = CGPoint(x: 4*width, y: 0)
            
            firstNumberLabel.text = "\(calculation.secondNumber)"
            secondNumberLabel.text = "\(calculation.result)"
            
            break
        case 2:
            firstNumberLabel.frame.origin = CGPoint(x: 0, y: 0)
            textField.frame.origin = CGPoint(x: 2*width, y: 0.1*height)
            secondNumberLabel.frame.origin = CGPoint(x: 4*width, y: 0)
            
            firstNumberLabel.text = "\(calculation.firstNumber)"
            secondNumberLabel.text = "\(calculation.result)"
            
            break
        case 3:
            firstNumberLabel.frame.origin = CGPoint(x: 0, y: 0)
            secondNumberLabel.frame.origin = CGPoint(x: 2*width, y: 0)
            textField.frame.origin = CGPoint(x: 4*width, y: 0.1*height)
            
            firstNumberLabel.text = "\(calculation.firstNumber)"
            secondNumberLabel.text = "\(calculation.secondNumber)"
            
            break
        default:
            break
        }
        
        operationLabel.text = calculation.operation.rawValue
        
    }
    
    /*:
     
     Here we check if the user's input is the expected one and give a feedback to him/her
     
     */
    
    @objc func checkInput() -> Bool {
        var correct = false
        
        if let text = self.textField.text, let input = Int(text) {
            switch (calculations[currentCalculation].emptyField) {
            case 1:
                correct = input == calculations[currentCalculation].firstNumber
                break
            case 2:
                correct = input == calculations[currentCalculation].secondNumber
                break
            case 3:
                correct = input == calculations[currentCalculation].result
                break
            default:
                break
            }
        }
        
        if(correct) {
            playSound(correctSound)
            
            if (currentCalculation < calculations.count - 1) {
                currentCalculation += 1
                
                showCalculation(calculations[currentCalculation])
            } else {
                calculationView.removeFromSuperview()
                
                if let mathLoveBaaloon = childNode(withName: "//mathLoveSprite") {
                    mathLoveBaaloon.run(.fadeIn(withDuration: 1))
                }
            }
        } else {
            print("erro")
            playSound(wrongSound)
        }
        
        return correct
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
    
    
    @objc func handleKeyboardShow(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            scene!.scaleMode = .aspectFill
            if let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                print("apareceu")
                interactionsNode.position = CGPoint(x: interactionsNode.position.x, y: interactionsNode.position.y - keyboardSize.height*0.6)
            }
        }
    }


    @objc func handleKeyboardHide(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            scene!.scaleMode = .aspectFit
            if ((userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                interactionsNode.position = CGPoint(x: 0, y: 0)

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

extension MathClassScene: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.text = ""
        
        return true
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
if let scene = MathClassScene(fileNamed: "MathClassScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFit
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//: [Next](@next)
