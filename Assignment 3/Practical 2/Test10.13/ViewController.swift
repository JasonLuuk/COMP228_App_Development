//
//  ViewController.swift
//  Test10.13
//
//  Created by Jason on 2021/10/13.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource{
    // Define text to represent the textfield inside the storyboard
    @IBOutlet weak var Text: UITextField!
    // Define a variable named inputText to initialize the user's input to 0
    var inputText = 0
    
    // Define a constant light name of line, a type of uitableview
    let line:UITableView=UITableView()
    
    // Set up a function called go that will be executed when the user presses the button go
    @IBAction func Go(_ sender: Any) {
        
        // Set the value of inputtext to be the value entered by the user converted to an int type
        // or set the default value to 0 when the user has no input
        inputText = Int(Text.text!) ?? 0
        // Show mytable inside the page
        myTable.isHidden = false
        // Refresh and Re display the data in mytable
        myTable.reloadData()
        // Set the input keyboard to be retracted when the user presses the button
        Text.resignFirstResponder()
    }
    
    // Define a function on tableview that determines how many rows are in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // set 100 rows
        return 100
    }
    
    // Functions for setting each cell in a tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set a constant myCell that is the default form of uitableviewcell, referencing a cell called myCell
        let myCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "myCell")
        // Set the text of mycell's textlabel to be the current indexpath multiplied by the entered value and get the result
        myCell.textLabel!.text="\(indexPath.row+1) X \(inputText) = \((indexPath.row+1)*inputText)"
        
        return myCell
    }
    
    // When the user wants to make a change to something in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        // Set a constant light called allowcharacters to allow only numbers
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        // Input is only allowed if the user has entered an allowed character
        return allowedCharacters.isSuperset(of: characterSet)
    }
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // When you enter the program, set the table to be hidden
        myTable.isHidden = true
        // The data source for the design inputbox is the current viewcontroller
        self.Text.delegate=self
    }
    

}

