//
//  DetailsViewController.swift
//  Assignment2 Uol Map
//
//  Created by Jason on 02/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
   
    // Define first uilabel to display the title, the name is titlelbl
    @IBOutlet weak var titleLbl: UILabel!
    // Define second uilabel to display year, the name is yearlbl
    @IBOutlet weak var yearLbl: UILabel!
    // Define third uilabel to display author, the name is authorlbl
    @IBOutlet weak var authorLbl: UILabel!
    // Define a uiimageview to put a big image, the name is imageview
    @IBOutlet weak var imageView: UIImageView!
    // Define a uinavigationitem to display location of the art, the name is topitem
    @IBOutlet weak var topItem: UINavigationItem!
    // Define a uibutton to like the art, the name is likebtn
    @IBOutlet weak var likeBtn: UIButton!
    // Define a uitextview to display the information of the arts, the nam is textview
    @IBOutlet weak var textView: UITextView!
    
    // Define a variable named titledetail, go to display title, and set to the empty string
    var titleDetail = ""
    // Define a variable named yeardetail, go to display year, and set to the empty string
    var yearDetail = ""
    // Define a variable named informationdetail, go to display information, and set to the empty string
    var informationDetail = ""
    // Define a variable named topdtitle, go to display toptitle, and set to the empty string
    var topTitle = ""
    // Define a variable named authordetail, go to display author, and set to the empty string
    var authorDetail = ""
    // Define a variable named imagefilename, go to display imagefilename, and set to the empty string
    var imageFileName = ""
    // Define a variable named likedetail, go to repersent like, and set to the empty string
    var likeDetail = ""
    // // Define a variable named urldetail, go to display url, and set to the the gaved link
    var urlDetail = URL(string: "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP228/artwork_images/")
    
    // Define a function to let user add art to favourite
    @IBAction func addToFavourite(_ sender: Any) {
        // Define a warning to remind the user that the above is not to be unliked
        let myAlert = UIAlertController(title: "Attention", message: "Are you sure to remove " + titleDetail + " from favourite list?", preferredStyle: UIAlertController.Style.alert)
        // Define a action to let user unlike the art
        let unLikeAction = UIAlertAction(title: "Unlike", style: UIAlertAction.Style.default, handler: { ACTION in
            //  Loop to find and delete the favourtie art
            for i in 0...likeListBase.count-1
            {
                print("i:"+String(i))
                print("count:"+String(likeListBase.count))
                if(i<likeListBase.count)
                {
                    print("content:"+likeListBase[i])
                    print("title:"+self.titleDetail)
                    //  Loop to find and delete the favourtie art
                    if likeListBase[i] == self.titleDetail
                    {
                        likeListBase.remove(at: i)
                    }
                    defaults.set(likeListBase, forKey: "mykey")
                }
                
            }
            self.likeBtn.setTitle("like", for: .normal)
            // pass value to viewcontroller, show that the art attitude was changed
            clickLoveData.1 = 0
        })
        // Define a action to let user continue to like the art
        let likeAction = UIAlertAction(title: "Continue to like", style: UIAlertAction.Style.default, handler: { ACTION in
            //  Loop to delete each line
            
        })
        // give the alert the action unlike
        myAlert.addAction(unLikeAction)
        // give the alert the action like
        myAlert.addAction(likeAction)
        // If the artwork is already bookmarked, a pop-up warns if you want to unbook it
        if(likeDetail=="heart.fill" && likeBtn.titleLabel?.text == "Unlike")
        {
            self.present(myAlert,animated: true,completion: nil)
        }
        else
        {
            // Add a favourite artwork to the artwork base list
            likeListBase.append(titleDetail)
            // Setting up storage for persistent variables
            defaults.set(likeListBase, forKey: "mykey")
            // pass the value talk to pre-view the love data is be changed
            clickLoveData.1 = 1
            print(likeListBase[0])
            // change the likebtn title
            likeBtn.setTitle("Unlike", for: .normal)
            // set the likedetail to fill heart
            likeDetail = "heart.fill"
        }
        // If the user has clicked, change the variable
        if(useclick)
        {
            // Tell the previous viewcontroller that the preferred artwork may have changed
            changeLove = true
        }
        else
        {
            // Tell the previous viewcontroller that the preferred artwork may have changed
            changeLove = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Set the toplocation to the incoming location
        topItem.title = topTitle
        // Set the author to the incoming author
        authorLbl.text = "By " + authorDetail
        // Set the title to the incoming title
        titleLbl.text = titleDetail
        // Determine the age of the artwork first
        if (yearDetail == "")
        {
            yearLbl.text = "No exact date"
        }
        else
        {
            yearLbl.text = "Made in " + yearDetail + "s"
        }
        // set the information from the incoming information
        textView.text = informationDetail
        // set the imagefilename and replace all the spaces in the artwork name with a special format that the browser will recognize
        imageFileName = imageFileName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "A%20Sunny%20Day%20by%20Endre%20Nemes.jpg"
        // Splice 2 links together
        urlDetail = URL(string: "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP228/artwork_images/" + imageFileName)
        // set the imageurl from the incoming view
        let imageUrl = urlDetail
        // set the data the to imagedata
        if(network)
        {
            let imageData = try! Data(contentsOf: imageUrl!)
            // Change the display mode of the image in the image view to filled
            imageView.contentMode = .scaleToFill
            // Set the image inside the view to the correct one
            imageView.image = UIImage(data: imageData)
        }
        else
        {
            let newImage = UIImage(named: "nonetwork")?.resized(to: CGSize(width: 60,height:60))
            imageView.image = newImage
        }
        // Determine if the text of a button or incoming text indicates that the current artwork has been liked
        if(likeBtn.titleLabel?.text == "like" || likeDetail == "heart.fill")
        {
            likeBtn.setTitle("Unlike", for: .normal)
        }
        else
        {
            likeBtn.setTitle("like", for: .normal)
        }
        // Set persistent variables and initialise them to strings
        var likeList = defaults.object(forKey: "mykey") as? [String]
        if(likeList != nil)
        {
            likeListBase = likeList!
        }
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

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
