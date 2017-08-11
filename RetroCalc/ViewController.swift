//
//  ViewController.swift
//  RetroCalc
//
//  Created by Scott Pelo on 4/20/17.
//  Copyright © 2017 Scott Pelo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation: String {
        case Add = "+"
        case Subtract = "-"
        case Divide = "/"
        case Multiply = "*"
        case Empty = "Empty"
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
		outputLbl.text = "0"
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
	}
	
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        playSound()
        processOperation(operation: Operation.Add)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        playSound()
        processOperation(operation: Operation.Subtract)
    }
    @IBAction func onDividePressed(sender: AnyObject) {
        playSound()
        processOperation(operation: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        playSound()
        processOperation(operation: Operation.Multiply)
    }
	@IBAction func onEqualPressed(sender: AnyObject) {
		playSound()
        processOperation(operation: currentOperation)
	}
    @IBAction func onClearPressed(sender: UIButton) {
        clearScreen()
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
	
	func clearScreen() {
		if outputLbl.text != "0" {
            outputLbl.text = "0"
			runningNumber = ""
			currentOperation = Operation.Empty
		}
	}
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
			
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

