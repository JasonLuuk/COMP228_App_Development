//
//  ViewController.swift
//  Table and Details Test 10.20
//
//  Created by Jason on 20/10/2021.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    // Define a variable named selectedPerson that refers to the person the user is currently clicking on
    var selectedPerson = -1
    
    // Define a variable named staff that stores all user information and profiles
    var staff = [("Phil","A1.20","phil@liverpool.ac.uk"),("Terry","A2.18","trp@liverpool.ac.uk"),("Valli","A2.12","V.Tamma@liverpool.ac.uk"),("Boris","A1.15","Konev@liverpool.ac.uk")]

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return as many rows as there are people in the staff table
        return staff.count
    }
    
    // Functions for setting each cell in a tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set a constant cell that is the default form of uitableviewcell, referencing a cell called myCell
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        // Define a constant staffname to be the name of the person in the current row in the array of staff
        let staffName=staff[indexPath.row].0
        // Pass the staffname variable to the text of the current cell
        cell.textLabel!.text = staffName
        // Set each cell to be followed by a disclosure indicator
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // This function is triggered when the user clicks on a cell in a tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // When the user clicks on the event, pass the variable of the row the user clicked on to selectPerson
        selectedPerson=indexPath.row
        // Use a segue with the name todetails to pass values
        performSegue(withIdentifier: "toDetails", sender: nil)
    }
    
    // Set whether a cell in a tableview can be edited or not
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Setting the edit mode of a cell in a tableview
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // When the edit mode is delete
        if (editingStyle == .delete) {
            // Removes the value of the currently selected position from the array
            staff.remove(at: indexPath.row)
            // Delete the row in the table that the current user clicked on
            tableView.deleteRows(at: [indexPath], with: .fade)	    
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Define a function called prepare, which prepares the segue for passing values
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the name of the segue definition is todetails
        if segue.identifier == "toDetails"
        {
            // Set a constant light named secondviewcontroller, through which the constant light is linked to the name detailsviewcontroller
            let secondViewController = segue.destination as! DetailsViewController
            // Set the secondviewcontroller's staffdetails to a value equal to the user's currently selected staff
            secondViewController.staffDetails=staff[selectedPerson]
        }
    }
    
    // When the user returns from a child viewcontroller, unwind is used to find the parent viewcontroller to jump to
    @IBAction func unwindToFristVC(_ unwindSegue: UIStoryboardSegue)
    {
        let _ = unwindSegue.source
    }
    

}

