//
//  PlacesViewController.swift
//  My Favourite Places
//
//  Created by Jason on 18/11/2021.
//

import UIKit
import CoreLocation

// Define a persistent storage variable with the name placesets
var placesSets = UserDefaults.standard.array(forKey: "mapLocation")
// Define a dictionary name for storing strings as places
var places = [[String : String]()]
// Define a variable named currentplace and initialize it to -1
var currentPlace = -1
// Define a flag variable to determine if the user has entered the map via didselect
var flag = false
class PlacesViewController: UITableViewController {

    // Define a table variable to refer to the tableview inside the storyboard
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // If it is empty
        if placesSets == nil
        {
            if places.count == 1 && places[0].count == 0
            {
                places.remove(at: 0)
                // Add these names and coordinates to the Places dictionary
                places.append(["name":"Ashton Building","lat":"53.406566","lon":"-2.966531"])
            }
            // Synchronising changes from places to persistent storage
            UserDefaults.standard.set(places,forKey: "mapLocation")
            placesSets = UserDefaults.standard.array(forKey: "mapLocation")
        }
        // Initialise current position to -1
        currentPlace = -1
        table.reloadData()
        flag = false
        
    }
    // MARK: - Table view data source
    
    // Defines the number of sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
//         #warning Incomplete implementation, return the number of sections
       
        return 1
    }
    
    // Set whether a cell in a tableview can be edited or not
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // This function is triggered when the user clicks on a cell in a tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        flag = true
        // When the user clicks on the event, pass the variable of the row the user clicked on to selectPerson
        currentPlace = indexPath.row
        // Use a segue with the name todetails to pass values
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    
    // Define a function on tableview that determines how many rows are in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // If it is empty
        if placesSets == nil
        {
            if places.count == 1 && places[0].count == 0
            {
                places.remove(at: 0)
                // Add these names and coordinates to the Places dictionary
                places.append(["name":"Ashton Building","lat":"53.406566","lon":"-2.966531"])
            }
            // Synchronising changes from places to persistent storage
            UserDefaults.standard.set(places,forKey: "mapLocation")
            placesSets = UserDefaults.standard.array(forKey: "mapLocation")
        }
        return placesSets!.count
    }

    // Functions for setting each cell in a tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set a constant cell that is the default form of uitableviewcell, referencing a cell called myCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        // If the data in the persistent store is not empty at the current row position
        if(placesSets![indexPath.row] as! Dictionary<String,String>)["name"] != nil
        {
            cell.textLabel?.text = (placesSets![indexPath.row] as! Dictionary<String,String>) ["name"]
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view, Setting the edit mode of a cell in a tableview
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // When the edit mode is delete
        if editingStyle == .delete {
            // Removes the value of the currently selected position from the placesets
            placesSets?.remove(at: indexPath.row)
            // Set the changed values into persistent storage
            UserDefaults.standard.set(placesSets, forKey: "mapLocation")
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    //currentplace = 0
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
