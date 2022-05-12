//
//  ViewController.swift
//  Guess Number
//
//  Created by Jason on 2021/10/7.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    // Define inputbox to represent the textfield inside the storyboard
    @IBOutlet weak var inputBox: UITextField!
    
    // The name of the action that defines the button is buttonguess
    @IBAction func buttonGuess(_ sender: Any) {
        
        // Define the constant inputtext to convert the font of the user input box to an int type
        let inputText = Int(inputBox.text!)
        // Define the constant dicreroll to be a variable of type int, in the range 2-12
        let diceRoll = Int.random(in:2..<13)

        // When the user's guess is equal to the random number given by the system
        if inputText == diceRoll
        {
            // Define a pop-up window controller named firstalert
            let firstAlert = UIAlertController(title: "Congratulate", message: "You are right!", preferredStyle: UIAlertController.Style.alert)
            // Define a pop-up action named promprtaction
            let promprtAction = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { ACTION in
                self.inputBox.text = ""
            })
            // Add an action to the pop-up control called promprt action
            firstAlert.addAction(promprtAction)
            // Add this popup event to the current viewcontroller
            self.present(firstAlert,animated: true,completion: nil)
        }
        else
        {
            // Define a pop-up window controller named firstalert
            let firstAlert = UIAlertController(title: "Sorry", message: "You are wrong!\n" + "Answer is " + String(diceRoll), preferredStyle: UIAlertController.Style.alert)
            // Define a pop-up action named promprtaction
            let promprtAction = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { ACTION in
                self.inputBox.text = ""
            })
            // Add an action to the pop-up control called promprt action
            firstAlert.addAction(promprtAction)
            // Add this popup event to the current viewcontroller
            self.present(firstAlert,animated: true,completion: nil)
        }
        // Set the input keyboard to be retracted when the user presses the button
        inputBox.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // The data source for the design inputbox is the current viewcontroller
        inputBox.delegate = self
        // Define the default display of the inputbox
        inputBox.placeholder = "Please type"
        // Define inputbox to be centred by default
        inputBox.textAlignment = .center
        
    }
    
    func textField(_ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String) -> Bool {
    // Define textfild to accept only the numbers 0123456789 as input
      let invalidCharacters =
        CharacterSet(charactersIn: "0123456789").inverted
      return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }
}
class PastelessTextField: UITextField {
  override func canPerformAction(
      _ action: Selector, withSender sender: Any?) -> Bool {
          // If there are any inputs other than numbers in the textfield, remove them directly
        return super.canPerformAction(action, withSender: sender)
        && (action == #selector(UIResponderStandardEditActions.cut)
        || action == #selector(UIResponderStandardEditActions.copy))
    }
}

