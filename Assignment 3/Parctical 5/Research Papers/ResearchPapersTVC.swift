//
//  ResearchPapersTVC.swift
//  Research Papers
//
//  Created by Jason on 25/11/2021.
//

import UIKit

class ResearchPapersTVC: UITableViewController {
    
    // Define reports as a variant of the technicalreports type
    var reports:technicalReports? = nil
    
    // Define the row in the table currently selected by the user as selectTechRow, initialized to -1
    var selectTechRow = -1
    
    // Define a variable thetable to represent the uitableview in the storyboard
    @IBOutlet var theTable: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()

    // Define the data for a url with the following address
    if let url = URL(string: "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP228/techreports/data.php?class=techreports2") {
    // Define session as a type of urlsession
    let session = URLSession.shared
    // Through the session's datatask method, return null if there is an error, and continue to do if it is responsible
    session.dataTask(with: url) { (data, response, err) in guard let jsonData = data else {
    return
    }
    do {
    // Defining a decoder
    let decoder = JSONDecoder()
    // Parsing json data to assign values to reportlist
    let reportList = try decoder.decode(technicalReports.self, from: jsonData)
    // Assignment report form to the current view controller's report
    self.reports = reportList
    // Execute these functions asynchronously
    DispatchQueue.main.async {
    self.updateTheTable()
    }
    } catch let jsonErr {
    // Output an error message when the json file type is incorrect
    print("Error decoding JSON", jsonErr)
    }
    }.resume()
    }
    }



    // MARK: - Table view data source

    // Defines the number of sections in the tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Define a function to refresh the content of a table
    func updateTheTable() {
        theTable.reloadData()
    }
    
    // This function is triggered when the user clicks on a cell in a tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // When the user clicks on the event, pass the variable of the row the user clicked on to selectPerson
        selectTechRow = indexPath.row
        // // Use a segue with the name todetails to pass values
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  // If the name of the segue definition is todetails
        if segue.identifier == "toDetail"
        {
            // Set a constant light named viewcontroller, through which the constant light is linked to the name viewcontroller
            let ViewController = segue.destination as! ViewController
            // Set the viewcontroller's titleoftech variable to the title of the user's currently selected row of reports' techreporst2, or to no title if there is none
            ViewController.titleOfTech = reports?.techreports2[selectTechRow].title ?? "no title"
            // Set the viewcontroller's year variable to the year of the user's currently selected row of reports' techreporst2, or to no year if there is none
            ViewController.year = reports?.techreports2[selectTechRow].year ?? "no year"
            // Set the viewcontroller's author variable to the author of the user's currently selected row of reports' techreporst2, or to no authors if there is none
            ViewController.author = reports?.techreports2[selectTechRow].authors ?? "no authors"
            // Set the viewcontroller's email variable to the email of the user's currently selected row of reports' techreporst2, or to no email if there is none
            ViewController.email = reports?.techreports2[selectTechRow].email ?? "no email"
            // Set the viewcontroller's abstract variable to the abstract of the user's currently selected row of reports' techreporst2, or to no abstract if there is none
            ViewController.abstract = reports?.techreports2[selectTechRow].abstract ?? "no abstract"
            // Set the viewcontroller's pdf variable to the pdf of the user's currently selected row of reports' techreporst2
            ViewController.pdf = reports?.techreports2[selectTechRow].pdf
        }
    }
    
    // Define a function on tableview that determines how many rows are in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reports?.techreports2.count ?? 0
    }

    // Functions for setting each cell in a tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set a constant cell that is the default form of uitableviewcell, referencing a cell called myCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "theCell", for: indexPath)
        // Pass the title of the user's currently selected row of reports' techreporst2 to the textlabel of the current cell or to no title if there is none
        cell.textLabel?.text = reports?.techreports2[indexPath.row].title ?? "no title"
        // Pass the author of the user's currently selected row of reports' techreporst2 to the textlabel of the current cell or to no author if there is none
        cell.detailTextLabel?.text = reports?.techreports2[indexPath.row].authors ?? "no authors"
        // Configure the cell...

        return cell
    }
    
    // When the user returns from a child viewcontroller, unwind is used to find the parent viewcontroller to jump to
    @IBAction func unwindToFristVC(_ unwindSegue: UIStoryboardSegue)
    {
        let _ = unwindSegue.source
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
