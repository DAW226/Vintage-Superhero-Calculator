//
//  ViewController.swift
//  Vintage Superhero Calculator
//
//  Created by Darin Wilson on 11/8/16.
//  Copyright © 2016 Darin Wilson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outletLbl: UILabel!
    
    var punchSound: AVAudioPlayer!
    var gruntSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Addition = "+"
        case Subtract = "-"
        case Empty = "Empty"
        case Clear = "0"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var resultString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
    let path = Bundle.main.path(forResource: "Cartoon_Punch", ofType: "wav")
    let soundURL = URL(fileURLWithPath: path!)
    
        do {
            try punchSound = AVAudioPlayer(contentsOf: soundURL)
            punchSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    let path2 = Bundle.main.path(forResource: "Cartoon_Grunt", ofType: "wav")
    let soundURL2 = URL(fileURLWithPath: path2!)
        
        do {
            try gruntSound = AVAudioPlayer(contentsOf: soundURL2)
            gruntSound.prepareToPlay()
        } catch let err as NSError{
                print(err.debugDescription)
        }
        
        outletLbl.text = "0"
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(operation: .Addition)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(operation: .Clear)
        outletLbl.text = "0"
    }

    
    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
        runningNumber += "\(sender.tag)"
        outletLbl.text = runningNumber
        
        
    }
    func operationSound() {
        if gruntSound.isPlaying{
            gruntSound.stop()
        }
        
        gruntSound.play()
    }
    
    func playSound() {
        if punchSound.isPlaying{
            punchSound.stop()
        }
        
        punchSound.play()
    }
    
    func processOperation(operation: Operation) {
        operationSound()
        if currentOperation != Operation.Empty {
            
            //A user selected an operator, but then selected another operator without first entering a number
                if runningNumber != "" {
                    rightValString = runningNumber
                    runningNumber = ""
                    
                    if currentOperation == Operation.Multiply {
                        resultString = "\(Double(leftValString)! * Double(rightValString)!)"
                    } else if currentOperation == Operation.Divide {
                        resultString = "\(Double(leftValString)! / Double(rightValString)!)"
                    } else if currentOperation == Operation.Addition {
                        resultString = "\(Double(leftValString)! + Double(rightValString)!)"
                    } else if currentOperation == Operation.Subtract {
                        resultString = "\(Double(leftValString)! - Double(rightValString)!)"
                    } else if currentOperation == Operation.Clear {
                        resultString = "\(Double())"
                    }

                    leftValString = resultString
                    outletLbl.text = leftValString
            }
                currentOperation = operation
        } else {
            // This is a first timer the operator has been pressed.
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
            }
        }
    
}

















