//
//  DetailsViewController.swift
//  Table and Details Test 10.20
//
//  Created by Jason on 20/10/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    // Define an outlet variable namelabel, representing a label inside the storyboard
    @IBOutlet weak var nameLabel: UILabel!
    // Define an outlet variable roomlabel, representing a label inside the storyboard
    @IBOutlet weak var roomLabel: UILabel!
    // Define an outlet variable emaillabel, representing a label inside the storyboard
    @IBOutlet weak var emailLabel: UILabel!
    // Define and initialise staffdetails
    var staffDetails=("","","")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The text defining namelbl is the first one inside staffdetails
        nameLabel.text=staffDetails.0
        // The text defining roomlbl is the second one inside staffdetails
        roomLabel.text=staffDetails.1
        // The text defining emaillbl is the third one inside staffdetails
        emailLabel.text=staffDetails.2

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
