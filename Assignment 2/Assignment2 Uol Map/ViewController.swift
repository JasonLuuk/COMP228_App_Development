//
//  ViewController.swift
//  Assignment2 Uol Map
//
//  Created by Jason on 02/12/2021.
//
// Attention ,the heart button can not be pressed
import MapKit
import UIKit
import CoreLocation
// Define a global variable named places that stores the coordinates of all locations
var places = [[String : String]()]
// Define a global variable name currentplace to determine what the current position is on
var currentPlace = 1
// Define a global variable to determine if the artwork has been changed to a preferred state
var changeLove = false
// Define a global variable to determine if the artwork's like button has been clicked
var useclick = false
// Define a global variable to pass in when the artwork's like is clicked, telling the controller which one
var clickLoveData = (0,0)
// Define a global variable to store the title party list of all the favourite artworks
var likeListBase:[String] = []
// Define a global variable to be used as persistent storage
let defaults = UserDefaults.standard

var network = false

// Customize a class to store all the information in the json file given by phil
// turning it from a structured data structure into a data structure I can understand
class CampusArts {
    var id: String
    var title: String
    var artist: String
    var yearOfWork: String
    var type: String?
    var Information:  String
    var lat: String
    var long: String
    var location: String
    var locationNotes: String
    var ImagefileName: String
    var thumbnail: URL
    var lastModified: String
    var enabled: String

    init(id: String,title: String,artist: String,yearOfWork: String,type: String,Information: String,lat: String,long: String,location: String,locationNotes: String,ImagefileName: String,thumbnail: URL,lastModified: String,enabled: String)
    {
        self.id = id
        self.title = title
        self.artist = artist
        self.yearOfWork = yearOfWork
        self.type = type
        self.Information = Information
        self.lat = lat
        self.long = long
        self.location = location
        self.locationNotes = locationNotes
        self.ImagefileName = ImagefileName
        self.thumbnail = thumbnail
        self.lastModified = lastModified
        self.enabled = enabled
    }
}

// Customize a class, put each individual piece of data inside the artwork in this class, and then put this class as a list in another class
class Details {
    var id: String
    var title: String
    var artist: String
    var yearOfWork: String
    var type: String?
    var Information:  String
    var lat: String
    var long: String
    var locationNotes: String
    var ImagefileName: String
    var thumbnail: URL
    var lastModified: String
    var love:String
    var enabled: String
    
    init(id: String,title: String,artist: String,yearOfWork: String,type: String,Information: String,lat: String,long: String,locationNotes: String,ImagefileName: String,thumbnail: URL,lastModified: String,love:String,enabled: String)
    {
        self.id = id
        self.title = title
        self.artist = artist
        self.yearOfWork = yearOfWork
        self.type = type
        self.Information = Information
        self.lat = lat
        self.long = long
        self.locationNotes = locationNotes
        self.ImagefileName = ImagefileName
        self.thumbnail = thumbnail
        self.lastModified = lastModified
        self.love = love
        self.enabled = enabled
    }
}

// Customize a class to put the data related to each location in the artwork, which means that
// different artworks in the same building have the same data, and put the previous class as an element of a list in this class
class CampusArtsDetail {
    var location: String
    var distance: Double
    var detail: [Details]
    init(location: String,distance : Double,detail: Details)
    {
        self.location = location
        self.distance = distance
        self.detail = [detail]
    }
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate {
    
    // Define a variable named map that references the mkmapview inside the storyboard
    @IBOutlet weak var map: MKMapView!
    // Define a variable named table that references the uitableview inside the storyboard
    @IBOutlet weak var table: UITableView!
    // Define a variable named blurview that references the uivisualeffectview inside the storyboard
    @IBOutlet var blurView: UIVisualEffectView!
    // Define a variable named popupview that references the uiview inside the storyboard
    @IBOutlet var popupView: UIView!
    // Defines a button behaviour which is inside the surprise and is used to return the view
    @IBAction func backButton(_ sender: Any) {
        // return the view, first out the view popview
        animateOut(desiredView: popupView)
        // return the view, first out the view blurview
        animateOut(desiredView: blurView)
        
    }
    
    // A variable named reports is defined to store the data in the format of the swift file detamodel and named reporst
    var reports:artsReports? = nil
    // Define an array that stores the campusarts data before processing the data and named artsetbase
    var artSetBase = [CampusArts]()
    // Define an array that stores the campusarts data and named artset
    var artSet = [CampusArtsDetail]()
    // Define a dictionary with this specific format to store the data being processed and named artgroupbylocation
    var artGroupByLocation:Dictionary<String?, [Array<CampusArts>.Element]> = [:]
    // Defined an array called locationnotelist to store all the locations
    var locationNotesList:[String] = []
    // A variable named locationmanager is defined to store all the locations that have been changed
    var locationManager = CLLocationManager()
    // Define a boolean variable named firstrun to determine if the user has moved
    var firstRun = true
    // Define a boolean variable named startTrackingTheUser to determine if user data is to be tracked
    var startTrackingTheUser = false
    // Define a variable of type int named selectArtRow to record the value of the current row when the user clicks on the table
    var selectArtRow = -1
    // Define a variable of type int named selectArtSection to record the value of the current section when the user clicks on the table
    var selectArtSection = -1
    // Define a boolean variable named flag to record when the user clicks on a anonation
    var flag = false
    
    // Define a string array with the variable name clicktitle to record
    // the title of the artwork the user clicked on when the user clicked on a specific building
    var clickTitle:[String] = []
    // Define a string array with the variable name clickurl to record
    // the url of the artwork the user clicked on when the user clicked on a specific building
    var clickUrl:[URL] = []
    // Define a string array with the variable name clickartist to record
    // the artist of the artwork the user clicked on when the user clicked on a specific building
    var clickArtist:[String] = []
    // Define a string array with the variable name clicklike to record
    // the like attitude of the artwork the user clicked on when the user clicked on a specific building
    var clickLike:[String] = []
    // Define a string with the variable name clicklocation to record the building name when the user clicked on a specific building
    var clickLocation = ""
    // Define a string array with the variable name clickyear to record
    // the year of the artwork the user clicked on when the user clicked on a specific building
    var clickYear:[String] = []
    // Define a string array with the variable name clickinformation to record
    // the information of the artwork the user clicked on when the user clicked on a specific building
    var clickInformation:[String] = []
    // Define a string array with the variable name clickimagefilename to record
    // the imagefilename of the artwork the user clicked on when the user clicked on a specific building
    var clickImageFileName:[String] = []
    var promptInformation = "Connected to Internet\nupdated to the lastset data"
    
    // This method defines how many section in the tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // If the user clicks on a specific place name just 1 section
        if(flag)
        {
            return 1
        }
        else
        {
            return artSet.count
        }
            
    }
    
    // This method defines how many rows there will be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If the user clicks on a specific place name just return user clickartist
        if(flag)
        {
            return clickArtist.count
        }
        else
        {
            return artSet[section].detail.count
        }
    }
    
    // This method defines what each cell inside the tableview will look like
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // First pass the current position to the intermediate variable
        selectArtRow = indexPath.row
        selectArtSection = indexPath.section
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        // When the user clicks on a single building, have the tableview return the artwork of the cells
        // inside the single section, otherwise it will return all of the
        if(flag)
        {
            myCell.textLabel?.font = UIFont(name: "HelvticaNeue-Bold", size: 16)
            myCell.textLabel?.text = clickTitle[indexPath.row]
            myCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
            myCell.detailTextLabel?.text = clickArtist[indexPath.row]
            // When users have internet, they give pictures with internet, when they don't have internet, they give pictures without internet
            if(network)
            {
                let url = clickUrl[indexPath.row]
                let data = try! Data(contentsOf: url)
                let newImage = UIImage(data: data)?.resized(to: CGSize(width: 60,height:60))
                myCell.imageView?.image = newImage
            }
            else
            {
                // When users have internet, they give pictures with internet, when they don't have internet, they give pictures without internet
                let newImage = UIImage(named: "nonetwork")?.resized(to: CGSize(width: 60,height:60))
                myCell.imageView?.image = newImage
            }
            // Set the end of the cell inside to a heart
            myCell.setAccessoryImage(to: UIImage(systemName: clickLike[indexPath.row])!, color: .red, selector: #selector(historyPressed), target: self)
        }
        // When the user clicks on a single building, have the tableview return the artwork of the cells
        // inside the single section, otherwise it will return all of the
        else
        {
            myCell.textLabel?.font = UIFont(name: "HelvticaNeue-Bold", size: 16)
            myCell.textLabel?.text = artSet[indexPath.section].detail[indexPath.row].title
            myCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
            myCell.detailTextLabel?.text = artSet[indexPath.section].detail[indexPath.row].artist
            // When users have internet, they give pictures with internet, when they don't have internet, they give pictures without internet
            if(network)
            {
                let url = artSet[indexPath.section].detail[indexPath.row].thumbnail
                let data = try! Data(contentsOf: url)
                let newImage = UIImage(data: data)?.resized(to: CGSize(width: 60,height:60))
                myCell.imageView?.image = newImage
            }
            else
            {
                let newImage = UIImage(named: "nonetwork")?.resized(to: CGSize(width: 60,height:60))
                myCell.imageView?.image = newImage
            }
            // Set the end of the cell inside to a heart
            myCell.setAccessoryImage(to: UIImage(systemName: artSet[indexPath.section].detail[indexPath.row].love)!, color: .red, selector: #selector(historyPressed), target: self)
        }
        return myCell
    }
    
    // this function is used to test
    @objc func historyPressed() {
    }
    
    // this function is when user selct and click on the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectArtRow = indexPath.row
        selectArtSection = indexPath.section
        // Passing data via segue to the specified viewcontroller
        performSegue(withIdentifier: "toDetails", sender: nil)
    }
    
    // This function is prepared for the data to be passed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"
        {
            // If the user clicks on a building on the map, the data associated with the click is passed
            if(flag)
            {
                let DetailsViewController = segue.destination as! DetailsViewController
                DetailsViewController.topTitle = clickLocation
                DetailsViewController.authorDetail = clickArtist[selectArtRow]
                DetailsViewController.imageFileName = clickImageFileName[selectArtRow]
                DetailsViewController.titleDetail = clickTitle[selectArtRow]
                DetailsViewController.yearDetail = clickYear[selectArtRow]
                DetailsViewController.informationDetail = clickInformation[selectArtRow]
                DetailsViewController.likeDetail = clickLike[selectArtRow]
                clickLoveData.0 = selectArtRow
                useclick = true
            }
            // If the user does not click on a building on the map, all the data belonging to the specific section is passed on.
            else
            {
                let DetailsViewController = segue.destination as! DetailsViewController
                DetailsViewController.topTitle = artSet[selectArtSection].location
                DetailsViewController.authorDetail = artSet[selectArtSection].detail[selectArtRow].artist
                DetailsViewController.imageFileName = artSet[selectArtSection].detail[selectArtRow].ImagefileName
                DetailsViewController.titleDetail = artSet[selectArtSection].detail[selectArtRow].title
                DetailsViewController.yearDetail = artSet[selectArtSection].detail[selectArtRow].yearOfWork
                DetailsViewController.informationDetail = artSet[selectArtSection].detail[selectArtRow].Information
                DetailsViewController.likeDetail = artSet[selectArtSection].detail[selectArtRow].love
                useclick = false
            }
        }
    }
    
    // This function allows you to customize the style and the style of each section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        // // Setting background of the location display on the section
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        // Setting size of the location display on the section
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width-15, height: 40))
        if(flag==true)
        {
            lbl.text = clickLocation
        }
        else
        {
            lbl.text = artSet[section].location
        }
        // Setting the font
        lbl.font = UIFont(name: "HelvticaNeue-Bold", size: 20)
        view.addSubview(lbl)
        return view
    }
    
    // This function returns the size of the specific header of each section of the tableview
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get the data on the map
        map.delegate = self
        // The code below is from the code already given in the lab file for week 8 of comp228
        places.append(["name":"Ashton Building","lat":"53.406566","lon":"-2.966531"])
        table.reloadData()
        guard currentPlace != -1 else { return }
        guard places.count > currentPlace else { return }
        guard let name = places[currentPlace]["name"] else { return }
        guard let lat = places[currentPlace]["lat"] else { return }
        guard let lon = places[currentPlace]["lon"] else { return }
        guard let latitude = Double(lat) else { return }
        guard let longitude = Double(lon) else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        self.map.addAnnotation(annotation)
        setJson()
        // The following code is all from comp228 obtaining the user's location
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        // sets the size of the blur view to be equal to size of overall view
        blurView.bounds = self.view.bounds
        // set width = 90% of the screen,height - 40% of the screen
        popupView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width*0.9, height: self.view.bounds.height*0.4)
        // Define persistent data name as likelist
        var likeList = defaults.object(forKey: "mykey") as? [String]
        if(likeList != nil)
        {
            likeListBase = likeList!
        }
        getAllItems()
        // Do any additional setup after loading the view.
    }
    
    // This method checks to see if the user is connected to the network, and if so, the pop-up window
    func checkNetwork()
    {
        if(network)
        {
            let firstAlert = UIAlertController(title: "Attention", message: promptInformation, preferredStyle: UIAlertController.Style.alert)
            // Define a action to check if user connect to internet
            let promprtAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { ACTION in
            })
            // give the alert the action promprtaction
            firstAlert.addAction(promprtAction)
            self.present(firstAlert,animated: true,completion: nil)
        }
    }
    
    //  // The following funct is all from comp228 obtaining the user's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationOfUser = locations[0]
        let latitude = locationOfUser.coordinate.latitude
        let longitude = locationOfUser.coordinate.longitude
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        sortByDistance(latitude,longitude)
        updateTheTable()
        if firstRun
        {
        firstRun = false
        let latDelta: CLLocationDegrees = 0.0025
        let lonDelta: CLLocationDegrees = 0.0025
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        
        //the following code is to prevent a bug which affects the zooming of the map to the user's location.
        //We have to leave a little time after our initial setting of the map's location and span,
        //before we can start centering on the user's location, otherwise the map never zooms in because the
        //intial zoom level and span are applied to the setCenter() method call, rather than our "requested"
        //ones, once they have taken effect on the map.
        //we setup a timer to set our boolean to true in 5 seconds.
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startUserTracking), userInfo: nil, repeats: false)
        }
        if startTrackingTheUser == true
        {
            map.setCenter(location, animated: true)
        }
    }
    
    // The following function is all from comp228 obtaining the user's location
    @objc func startUserTracking()
    {
        startTrackingTheUser = true
    }
    
    // This function calculates the current position of the user and the positions of all the artefacts
    // compares the absolute values to get the relative distances and swaps them using a bubble sort
    func sortByDistance(_ lat:CLLocationDegrees,_ long:CLLocationDegrees)
    {
        if artSet.count > 0 && flag == false
        {
            
        // Get the current position and calculate the absolute distance to all artworks
        for i in 0...artSet.count-1
        {
            let artLat = artSet[i].detail[0].lat
            let artLong =  artSet[i].detail[0].long
            let x = abs(Double(artLat)! - lat)
            let y = abs(Double(artLong)! - long)
            let distance = sqrt(x*x+y*y)*1000
            artSet[i].distance = distance
        }
        
        // Use bubble sort to swap positions
        for i in 0...artSet.count-2
        {
            for j in (i+1)...artSet.count-1
            {
                if(artSet[i].distance > artSet[j].distance)
                {
                    let temp = artSet[j]
                    artSet[j] = artSet[i]
                    artSet[i] = temp
                }
            }
        }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkLike()
        // If user have a favourite artwork, change the favourite value of the artwork
        if(changeLove)
        {
            if(clickLoveData.1 == 1)
            {
                clickLike[clickLoveData.0] = "heart.fill"
            }
            else
            {
                clickLike[clickLoveData.0] = "heart"
            }
        }
        // update table
        updateTheTable()
        // update core data
        getAllItems()
        super.viewDidAppear(animated)
        // set navigationbar title to University Of Liverpool Artwork Map
        self.navigationController?.navigationBar.topItem?.title = "University Of Liverpool Artwork Map"
    }
    // Animate in a specified view
    func animatenIn(desiredView: UIView)
    {
        let bakgroundView = self.view!
        // attach our desired view to the screen (self.view/backgroundView)
        bakgroundView.addSubview(desiredView)
        // sets the view's scaling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = self.view.center
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    
    // This function is to check if the user likes an artwork
    func checkLike()
    {
        if(artSet.count>0)
        {
            for i in 0...artSet.count-1
            {
                for j in 0...artSet[i].detail.count-1
                {
                    if likeListBase.contains(artSet[i].detail[j].title)
                    {
                        artSet[i].detail[j].love = "heart.fill"
                    }
                    else
                    {
                        artSet[i].detail[j].love = "heart"
                    }
                }
            }
        }
        
    }
    
    // Animate out a specified view
    func animateOut(desiredView:UIView)
    {
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        })
    }
    
    // This function mainly tries to read or get json data
    func setJson()
    {
        //2021-11-23
        if let url = URL(string: "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP228/artworksOnCampus/data.php?class=campusart") {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
        // When the json file is not read
        // The code is very similar to the code bleow, as they do most of the same work,
        // except that one is in the presence of the network and the other is in the absence of
        // the network, which requires them to be determined and loaded separately
        if (err != nil)
            {
            network = false
            for i in 0...self.models.count-1
            {
                self.artSetBase.append(CampusArts.init(id: self.models[i].id!, title: self.models[i].title!, artist: self.models[i].artist!, yearOfWork: self.models[i].yearOfWork!, type: self.models[i].type!, Information: self.models[i].information!, lat: self.models[i].lat!, long: self.models[i].long!
                                                       , location: self.models[i].location!, locationNotes: self.models[i].locationNotes!, ImagefileName: self.models[i].imgefileName!, thumbnail: self.models[i].thumbnail!, lastModified: self.models[i].lastModified!, enabled: self.models[i].enabled!))
            }
            self.locationNotesList = Array(Set(self.locationNotesList))
            // Separating artsetbase data by dictionary form
            self.artGroupByLocation = Dictionary(grouping: self.artSetBase) { $0.location}
            for (key,value) in self.artGroupByLocation
            {
                if(value.count == 1)
                {
                    self.artSet.append(self.dealDict(value[0],key: key))
                }
                else if(value.count==2)
                {
                    self.artSet.append(self.dealDict(value[0],key: key))
                    for i in 0...self.artSet.count-1
                    {
                        if(self.artSet[i].location == key!)
                        {
                            self.artSet[i].detail.append(self.dealDictsimple(value[1]))
                        }
                    }
                }
                else
                {
                    self.artSet.append(self.dealDict(value[0],key: key))
                    for i in 0...self.artSet.count-1
                    {
                        if(self.artSet[i].location == key!)
                        {
                            for j in 1...value.count-1
                            {
                                self.artSet[i].detail.append(self.dealDictsimple(value[j]))
                            }
                        }
                    }
                }
            }
            self.checkLike()
            // Traversing the data of all artwork locations and annotating them on the map
            for i in 0...self.artSet.count-1
            {
                let artwork = Artwork(
                    title: self.artSet[i].location,
                    locationName: self.artSet[i].location,
                  discipline: "123",
                  coordinate: CLLocationCoordinate2D(latitude: Double(self.artSet[i].detail[0].lat) ?? 53.406566, longitude: Double(self.artSet[i].detail[0].long) ?? -2.966531))
                // set annotation on the map
                self.map.addAnnotation(artwork)
            }
            return
        }
        //
        guard let jsonData = data else {return}
        do
        {
        let decoder = JSONDecoder()
        let reportList = try decoder.decode(artsReports.self, from: jsonData)
        self.reports = reportList
        // The code below is very similar to the code above, as they do most of the same work,
        // except that one is in the presence of the network and the other is in the absence of
        // the network, which requires them to be determined and loaded separately
        DispatchQueue.main.async
            {
                network = true
                self.checkNetwork()
                for i in 0...reportList.campusart.count-1
                {
                    if(reportList.campusart[i].enabled == "1")
                    {
                        self.locationNotesList.append(reportList.campusart[i].locationNotes)
                        self.artSetBase.append(self.dealBeforeDict(reportList, i: i))
                        if(self.models.count==0)
                        {
                            self.createItems(id: self.artSetBase[i].id, title: self.artSetBase[i].title, artist: self.artSetBase[i].artist, yearOfWork: self.artSetBase[i].yearOfWork, type: self.artSetBase[i].type, information: self.artSetBase[i].Information, lat: self.artSetBase[i].lat, long:self.artSetBase[i].long, locaiton: self.artSetBase[i].location, locationNotes: self.artSetBase[i].locationNotes, imagefileName: self.artSetBase[i].ImagefileName, thumbnail: self.artSetBase[i].thumbnail, lastModified: self.artSetBase[i].lastModified, enabled: self.artSetBase[i].enabled, like: "heart")
                        }
                        
                    }
                }
                self.locationNotesList = Array(Set(self.locationNotesList))
                self.artGroupByLocation = Dictionary(grouping: self.artSetBase) { $0.location}
                for (key,value) in self.artGroupByLocation
                {
                    if(value.count == 1)
                    {
                        self.artSet.append(self.dealDict(value[0],key: key))
                    }
                    else if(value.count==2)
                    {
                        self.artSet.append(self.dealDict(value[0],key: key))
                        for i in 0...self.artSet.count-1
                        {
                            if(self.artSet[i].location == key!)
                            {
                                //self.artSet[i].detail.append(self.dealDictsimple(value[1]))
                                self.artSet[i].detail.append(self.dealDictsimple(value[1]))
                            }
                        }
                    }
                    else
                    {
                        self.artSet.append(self.dealDict(value[0],key: key))
                        for i in 0...self.artSet.count-1
                        {
                            if(self.artSet[i].location == key!)
                            {
                                for j in 1...value.count-1
                                {
                                    self.artSet[i].detail.append(self.dealDictsimple(value[j]))
                                }
                            }
                        }
                    }
                }
                self.checkLike()
                // Traversing the data of all artwork locations and annotating them on the map
                for i in 0...self.artSet.count-1
                {
                    let artwork = Artwork(
                        title: self.artSet[i].location,
                        locationName: self.artSet[i].location,
                      discipline: "123",
                      coordinate: CLLocationCoordinate2D(latitude: Double(self.artSet[i].detail[0].lat) ?? 53.406566, longitude: Double(self.artSet[i].detail[0].long) ?? -2.966531))
                    self.map.addAnnotation(artwork)
                }
                //  // set annotation on the map
                self.updateTheTable()
            }
        }
        catch let jsonErr
        {
            print("Error decoding JSON", jsonErr)
        }
        }.resume()
        }
    }
    
    // What phil taught me to simplify the construction of my custom data structure
    func dealBeforeDict(_ artwork:artsReports,i:Int) -> CampusArts
    {
        let newObj =   CampusArts.init(id: artwork.campusart[i].id, title: artwork.campusart[i].title, artist:artwork.campusart[i].artist, yearOfWork: artwork.campusart[i].yearOfWork, type: artwork.campusart[i].type ?? "null", Information: artwork.campusart[i].Information, lat: artwork.campusart[i].lat, long: artwork.campusart[i].long, location: artwork.campusart[i].location, locationNotes: artwork.campusart[i].locationNotes, ImagefileName: artwork.campusart[i].ImagefileName, thumbnail: artwork.campusart[i].thumbnail, lastModified: artwork.campusart[i].lastModified, enabled: artwork.campusart[i].enabled)
        return newObj
    }
  
    // What phil taught me to simplify the construction of my custom data structure
    func dealDict(_ artwork: CampusArts, key: String? ) -> CampusArtsDetail
    {
        let newObj = CampusArtsDetail.init(location: key!,distance: 0, detail: Details.init(id: artwork.id, title: artwork.title, artist: artwork.artist, yearOfWork: artwork.yearOfWork, type: artwork.type!, Information: artwork.Information, lat: artwork.lat, long: artwork.long, locationNotes: artwork.locationNotes, ImagefileName: artwork.ImagefileName, thumbnail: artwork.thumbnail, lastModified: artwork.lastModified, love: "heart", enabled: artwork.enabled))
        return newObj
    }
    
    // What phil taught me to simplify the construction of my custom data structure
    func dealDictsimple(_ artwork: CampusArts) -> Details
    {
        let newObj = Details.init(id: artwork.id, title: artwork.title, artist: artwork.artist, yearOfWork: artwork.yearOfWork, type: artwork.type!, Information: artwork.Information, lat: artwork.lat, long: artwork.long, locationNotes: artwork.locationNotes, ImagefileName: artwork.ImagefileName, thumbnail: artwork.thumbnail, lastModified: artwork.lastModified, love: "heart", enabled: artwork.enabled)
        return newObj
    }

    // This function
    func updateTheTable() {
        table.reloadData()
    }
    
    // This method doesn't make a lot of sense, it's a test
    func mapView(_ mapView:MKMapView,didTapAt coordinate:CLLocationCoordinate2D)
    {
        print("---------")
    }
    // When the user clicks on the annotation above the map,
    // the value needs to be passed to the page so that the page remembers what the user clicked on
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        flag = true
        for i in 0...artSet.count-1
        {
            if(artSet[i].location == view.annotation!.title!!)
            {
                
                for j in 0...artSet[i].detail.count-1
                {
                    clickTitle.append(artSet[i].detail[j].title)
                    clickUrl.append(artSet[i].detail[j].thumbnail)
                    clickArtist.append(artSet[i].detail[j].artist)
                    clickLike.append(artSet[i].detail[j].love)
                    clickLocation = artSet[i].location
                    clickYear.append(artSet[i].detail[j].yearOfWork)
                    clickInformation.append(artSet[i].detail[j].Information)
                    clickImageFileName.append(artSet[i].detail[j].ImagefileName)
                }
            }
        }
        updateTheTable()
        view.image = nil
        let mapsButton = UIButton(frame: CGRect(
          origin: CGPoint.zero,
          size: CGSize(width: 48, height: 48)))
        mapsButton.setBackgroundImage(#imageLiteral(resourceName: "liverpool"), for: .normal)
        view.leftCalloutAccessoryView = mapsButton
    }
    
    // This function is used when the user un-clicks on the annotation inside the map
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        flag = false
        clickUrl.removeAll()
        clickArtist.removeAll()
        clickTitle.removeAll()
        clickYear.removeAll()
        clickLocation = ""
        clickInformation.removeAll()
        clickImageFileName.removeAll()
        clickLike.removeAll()
        updateTheTable()
    }
    

    // This function is designed to respond to user clicks on the image inside the annotation
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let artwork = view.annotation as? Artwork else {
            return
          }
        animatenIn(desiredView: blurView)
        animatenIn(desiredView: popupView)
    }
    // Define a variable that holds the core data
    var models = [CampusCoredata]()
    // Initialize the content of the core data to content
    let contenxt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
    // Update all core data to the latest
    func getAllItems()
    {
        do{
            models  = try contenxt.fetch(CampusCoredata.fetchRequest())
        }
        catch{
        }

    }

    
    // Initialise the core data by calling this method
    func createItems(id:String,title:String,artist:String,yearOfWork:String,type:String?,information:String,lat:String,long:String,locaiton:String,locationNotes:String,imagefileName:String,thumbnail:URL,lastModified:String,enabled:String,like:String)
    {
        let newItem = CampusCoredata(context: contenxt)
        newItem.id = id
        newItem.title = title
        newItem.artist = artist
        newItem.yearOfWork = yearOfWork
        newItem.type = type
        newItem.information = information
        newItem.lat = lat
        newItem.long = long
        newItem.location = locaiton
        newItem.locationNotes = locationNotes
        newItem.imgefileName = imagefileName
        newItem.thumbnail = thumbnail
        newItem.lastModified = lastModified
        newItem.enabled = enabled
        newItem.like = like
        do{
            try contenxt.save()
            getAllItems()
        }
        catch
        {

        }

    }
    
    //delete the core data by calling this method
    func deleteItem(item:CampusCoredata)
    {
        contenxt.delete(item)
        do{
            try contenxt.save()
        }
        catch{

        }
    }

    //Update the core data by calling this method
    func updateItem(item:CampusCoredata,id:String,title:String,artist:String,yearOfWork:String,type:String?,information:String,lat:String,long:String,locaiton:String,locationNotes:String,imagefileName:String,thumbnail:URL,lastModified:String,enabled:String,like:String)
    {
        item.id = id
        item.title = title
        item.artist = artist
        item.yearOfWork = yearOfWork
        item.type = type
        item.information = information
        item.lat = lat
        item.long = long
        item.location = locaiton
        item.locationNotes = locationNotes
        item.imgefileName = imagefileName
        item.thumbnail = thumbnail
        item.lastModified = lastModified
        item.enabled = enabled
        item.like = like
        do{
            try contenxt.save()
        }
        catch{

        }
    }
    
}

// This extension comes from the web and is for customizing the
// rightmost button inside a cell, passing in an image, colour, an objectc method and a target
extension UITableViewCell {
func setAccessoryImage(to image: UIImage, color: UIColor, selector: Selector?, target: Any?) {
    self.accessoryType = .none

    let button = UIButton(type: .custom)
    button.setImage(image, for: .normal)
    let size = self.textLabel?.font.pointSize ?? UIFont.preferredFont(forTextStyle: .body).pointSize
    button.setPreferredSymbolConfiguration(.init(pointSize: size, weight: .regular, scale: UIImage.SymbolScale.large), forImageIn: .normal)
    button.sizeToFit()
    if selector != nil {
        button.addTarget(target, action: selector!, for: .touchUpInside)
    }
    button.tintColor = color
    self.accessoryView = button
}
}

