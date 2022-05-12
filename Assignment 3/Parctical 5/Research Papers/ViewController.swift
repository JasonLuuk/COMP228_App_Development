//
//  ViewController.swift
//  Research Papers
//
//  Created by Jason on 25/11/2021.
//

import UIKit

class ViewController: UIViewController {

    // Define an outlet variable titleLbl, representing a label inside the storyboard
    @IBOutlet weak var titleLbl: UILabel!
    // Define an outlet variable yearLbl, representing a label inside the storyboard
    @IBOutlet weak var yearLbl: UILabel!
    // Define an outlet variable authorLbl, representing a label inside the storyboard
    @IBOutlet weak var authorLbl: UILabel!
    // Define an outlet variable emailLbl, representing a label inside the storyboard
    @IBOutlet weak var emailLbl: UILabel!
    // Define an outlet variable abstractText, representing a UITextView inside the storyboard
    @IBOutlet weak var abstractText: UITextView!
    // Define an outlet variable urlText, representing a UITextView inside the storyboard
    @IBOutlet weak var urlText: UITextView!
    
    // Set a string variable named titleOftech and initialize it to null
    var titleOfTech = ""
    // Set a string variable named year and initialize it to null
    var year = ""
    // Set a string variable named author and initialize it to null
    var author = ""
    // Set a string variable named email and initialize it to null
    var email = ""
    // Set a string variable named abstract and initialize it to null
    var abstract = ""
    // Set a url variable named titleOftech and initialize it to apple website
    var pdf = URL(string: "http://www.apple.com")
    
    override func viewDidLoad() {
        
        // Set the break mode of titleLbl
        titleLbl.lineBreakMode = .byWordWrapping
        // Set the number of lines in titlelbl to infinite
        titleLbl.numberOfLines = 0
        // Set the text value of titlelbl to titleoftech
        titleLbl.text = titleOfTech
        // Set the text value of yearlbl to year plus year
        yearLbl.text = "Year:" + year
        // Set the break mode of authorLbl
        authorLbl.lineBreakMode = .byWordWrapping
        // Set the number of lines in authorlbl to infinite
        authorLbl.numberOfLines = 0
        // If author doesn't exist, tell the reader it doesn't exist
        if author == "no authors"
        {
            authorLbl.text = "Sorry,no author"
        }
        else
        {
            authorLbl.text = author
        }
        // If email doesn't exist, tell the reader it doesn't exist
        if email == "no email"
        {
            emailLbl.text = "Sorry,no email"
        }
        else
        {
            emailLbl.text = "Email: " + email
        }
        abstractText.text = abstract
        // If pdf doesn't exist, tell the reader it doesn't available
        if(pdf == nil)
        {
            urlText.text = "Sorry, URL is not available"
        }
        else
        {
            urlText.text = "View Online: " + pdf!.absoluteString
        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

