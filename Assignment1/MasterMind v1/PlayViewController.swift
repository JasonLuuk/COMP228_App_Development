//
//  PlayViewController.swift
//  MasterMind v1
//
//  Created by Jason on 28/10/2021.
//

import UIKit
// Set global persistent variables to monitor game wins and losses
var numbersOfWin = UserDefaults.standard.integer(forKey: "numbersOfWin")
var numbersOfLost = UserDefaults.standard.integer(forKey: "numbersOfLost")
class PlayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var currentFirstImage: UIImageView!
    @IBOutlet weak var currentSecondImage: UIImageView!
    @IBOutlet weak var currentThirdImage: UIImageView!
    @IBOutlet weak var currentFourthImage: UIImageView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var tipText: UILabel!
    @IBOutlet weak var rePlay: UIButton!
    @IBOutlet weak var conFirm: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var keyImage1: UIImageView!
    @IBOutlet weak var keyImage2: UIImageView!
    @IBOutlet weak var keyImage3: UIImageView!
    @IBOutlet weak var keyImage4: UIImageView!
    // Defining an array of images
    let imageArray = ["base","grey","yellow","green","orange","blue","red"]
    // Defining an array of images for hints
    let promptArray = ["base small","black blob","white blob"]
    // Defining password
    var passWord = [Int]()
    var blackPoint = 0
    var whitePoint = 0
    var emptyPoint = 0
    var currentGuess = [Int]()
    var currentLine = 0
    // Set a variable similar to currentline
    var acc = 0
    var currentResult = [Int]()
    // Setting up two-dimensional arrays
    var guessHistory = [[Int]](repeating: [Int](repeating:0, count: 4),count:10)
    var guessResultHistory = [[Int]](repeating: [Int](repeating:0, count: 4),count:10)
    // Represent the state of the game, 1 = win, 2 = lost
    var gameStatus = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentLine + 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Display the user's current selection
    func showCureent()
    {
        if currentGuess.count==0
        {
            currentFirstImage.image=UIImage(named: imageArray[0])
            currentSecondImage.image=UIImage(named: imageArray[0])
            currentThirdImage.image=UIImage(named: imageArray[0])
            currentFourthImage.image=UIImage(named: imageArray[0])
            conFirm.isEnabled = false
            delete.isEnabled = false
        }
        else if currentGuess.count==1{
            currentFirstImage.image=UIImage(named: imageArray[currentGuess[0]])
            currentSecondImage.image=UIImage(named: imageArray[0])
            currentThirdImage.image=UIImage(named: imageArray[0])
            currentFourthImage.image=UIImage(named: imageArray[0])
            conFirm.isEnabled = false
            delete.isEnabled = true
        }
        else if currentGuess.count==2{
            currentFirstImage.image=UIImage(named: imageArray[currentGuess[0]])
            currentSecondImage.image=UIImage(named: imageArray[currentGuess[1]])
            currentThirdImage.image=UIImage(named: imageArray[0])
            currentFourthImage.image=UIImage(named: imageArray[0])
            conFirm.isEnabled = false
            delete.isEnabled = true
        }
        else if currentGuess.count==3{
            currentFirstImage.image=UIImage(named: imageArray[currentGuess[0]])
            currentSecondImage.image=UIImage(named: imageArray[currentGuess[1]])
            currentThirdImage.image=UIImage(named: imageArray[currentGuess[2]])
            currentFourthImage.image=UIImage(named: imageArray[0])
            conFirm.isEnabled = false
            delete.isEnabled = true
        }
        else if currentGuess.count==4{
            currentFirstImage.image=UIImage(named: imageArray[currentGuess[0]])
            currentSecondImage.image=UIImage(named: imageArray[currentGuess[1]])
            currentThirdImage.image=UIImage(named: imageArray[currentGuess[2]])
            currentFourthImage.image=UIImage(named: imageArray[currentGuess[3]])
            conFirm.isEnabled = true
            delete.isEnabled = true
        }
        else if currentGuess.count > 4
        {
            currentGuess.removeLast()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        myTable.backgroundColor = UIColor(red: 236/255, green: 229/255, blue: 206/255, alpha: 1)
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",for:indexPath) as! TableTableViewCell
        // Remove the dividing line between each cell
        tableView.separatorStyle = .none
        cell.backgroundColor = UIColor(red: 236/255, green: 229/255, blue: 206/255, alpha: 1)
        // By determining the size of the indexpath, each row is operated on separately and given hints
        if indexPath.row == 0 && acc > 0
        {
            cell.textLabel!.text = "1"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[0][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[0][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[0][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[0][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[0][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[0][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[0][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[0][3]])
            return cell
        }
        else if indexPath.row == 1
        {
            cell.textLabel!.text = "2"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[1][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[1][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[1][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[1][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[1][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[1][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[1][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[1][3]])
            return cell
        }
        else if indexPath.row == 2
        {
            cell.textLabel!.text = "3"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[2][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[2][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[2][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[2][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[2][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[2][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[2][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[2][3]])
            return cell
        }
        else if indexPath.row == 3
        {
            cell.textLabel!.text = "4"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[3][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[3][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[3][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[3][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[3][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[3][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[3][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[3][3]])
            return cell
        }
        else if indexPath.row == 4
        {
            cell.textLabel!.text = "5"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[4][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[4][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[4][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[4][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[4][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[4][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[4][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[4][3]])
            return cell
        }
        else if indexPath.row == 5
        {
            cell.textLabel!.text = "6"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[5][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[5][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[5][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[5][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[5][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[5][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[5][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[5][3]])
            return cell
        }
        else if indexPath.row == 6
        {
            cell.textLabel!.text = "7"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[6][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[6][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[6][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[6][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[6][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[6][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[6][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[6][3]])
            return cell
        }
        else if indexPath.row == 7
        {
            cell.textLabel!.text = "8"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[7][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[7][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[7][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[7][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[7][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[7][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[7][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[7][3]])
            return cell
        }
        else if indexPath.row == 8
        {
            cell.textLabel!.text = "9"
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[8][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[8][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[8][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[8][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[8][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[8][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[8][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[8][3]])
            return cell
        }
        else if indexPath.row == 9
        {
            cell.firstGuessImage.image=UIImage(named: imageArray[guessHistory[9][0]])
            cell.secondGuessImage.image=UIImage(named: imageArray[guessHistory[9][1]])
            cell.thirdGuessImage.image=UIImage(named: imageArray[guessHistory[9][2]])
            cell.fourthGuessImage.image=UIImage(named: imageArray[guessHistory[9][3]])
            cell.guessResult1.image=UIImage(named: promptArray[guessResultHistory[9][0]])
            cell.guessResult2.image=UIImage(named: promptArray[guessResultHistory[9][1]])
            cell.guessResult3.image=UIImage(named: promptArray[guessResultHistory[9][2]])
            cell.guessResult4.image=UIImage(named: promptArray[guessResultHistory[9][3]])
            return cell
        }
        else
        {
            return cell
        }
    }
    
    // Add the colour of the current click to the current guess array
    @IBAction func clickGrey(_ sender: Any) {
        currentGuess.append(1)
        showCureent()
    }
    @IBAction func clickYellow(_ sender: Any) {
        currentGuess.append(2)
        showCureent()
    }
    @IBAction func clickGreen(_ sender: Any) {
        currentGuess.append(3)
        showCureent()
    }
    @IBAction func clickOrange(_ sender: Any) {
        currentGuess.append(4)
        showCureent()
    }
    @IBAction func clickBlue(_ sender: Any) {
        currentGuess.append(5)
        showCureent()
    }
    
    @IBAction func clickRed(_ sender: Any) {
        currentGuess.append(6)
        showCureent()
    }
    @IBAction func ClickDelte(_ sender: Any) {
        currentGuess.removeLast()
        showCureent()
    }
    @IBAction func clickConfirm(_ sender: Any) {
        // Transferring current guesses into the history
        guessHistory[acc] = currentGuess
        // Debug
        if currentLine < 0{
            currentLine = 0
        }
        calculateTips()
        // Transferring current hints into the history
        guessResultHistory[acc] = currentResult
        // If played less than 10 times then continue to play
        if acc > 0 && acc < 9
        {
            currentLine = currentLine + 1
            acc = acc + 1
        }
        else if acc == 9
        {
            gameStatus = 2
        }
        else
        {
            acc = acc + 1
        }
        // If the black point is four, the user wins
        if blackPoint == 4
        {
            gameStatus = 1
        }
        // Zeroing out the number of tips
        blackPoint = 0
        whitePoint = 0
        emptyPoint = 0
        currentResult = [Int]()
        currentGuess = [Int]()
        showCureent()
        myTable.reloadData()
        gameMonitor()
    }
    
    //  To calculate the displayed tips
    func calculateTips()
    {
        for i in 0..<4
        {
            // If the current guess includes the password
            if currentGuess.contains(passWord[i])
            {
                if currentGuess[i] == passWord[i]
                {
                    blackPoint += 1
                }
                else
                {
                    whitePoint += 1
                }
            }
        }
        emptyPoint = currentGuess.count-blackPoint-whitePoint
        
        if emptyPoint == 0
        {
            if blackPoint == 0
            {
                for _ in 0..<4
                {
                    currentResult.append(2)
                }
            }
            else if blackPoint == 1
            {
                currentResult.append(1)
                for _ in 0..<3
                {
                    currentResult.append(2)
                }
            }
            else if blackPoint == 2
            {
                currentResult.append(1)
                currentResult.append(1)
                currentResult.append(2)
                currentResult.append(2)
            }
            else if blackPoint == 3
            {
                for _ in 0..<3
                {
                    currentResult.append(1)
                }
                currentResult.append(2)
            }
            else
            {
                for _ in 0..<4
                {
                    currentResult.append(1)
                }
            }
        }
        else if emptyPoint == 1
        {
            if blackPoint == 0
            {
                for _ in 0..<3
                {
                    currentResult.append(2)
                }
            }
            else if blackPoint == 1
            {
                currentResult.append(1)
                currentResult.append(2)
                currentResult.append(2)
            }
            else if blackPoint == 2
            {
                currentResult.append(1)
                currentResult.append(1)
                currentResult.append(2)
            }
            else
            {
                for _ in 0..<3
                {
                    currentResult.append(1)
                }
            }
            currentResult.append(0)
        }
        else if emptyPoint == 2
        {
            if blackPoint == 0
            {
                for _ in 0..<2
                {
                    currentResult.append(2)
                }
            }
            else if blackPoint == 1
            {
                currentResult.append(1)
                currentResult.append(2)
            }
            else
            {
                currentResult.append(1)
                currentResult.append(1)
            }
            currentResult.append(0)
            currentResult.append(0)
        }
        else if emptyPoint == 3
        {
            if blackPoint == 0
            {
                currentResult.append(2)
            }
            else
            {
                currentResult.append(1)
            }
            currentResult.append(0)
            currentResult.append(0)
            currentResult.append(0)
        }
        else
        {
            for _ in 0..<4
            {
                currentResult.append(0)
            }
        }
    }
    @IBAction func rePlay(_ sender: Any) {
        if gameStatus == 2
        {
            // Exit this view
            animateOut(desiredView: popUpView)
            animateOut(desiredView: blurView)
            // Change these intermediate variables to 0
            acc = 0
            guessHistory = [[Int]](repeating: [Int](repeating:0, count: 4),count:10)
            guessResultHistory = [[Int]](repeating: [Int](repeating:0, count: 4),count:10)
            //  Loop to delete each line
            for _ in 0...currentLine
            {
                currentLine = currentLine - 1
                myTable.deleteRows(at: [IndexPath(row: 0, section: 0)], with:  .fade)
            }
            gameStatus = 0
            setPassword()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the background colour
        view.backgroundColor = UIColor(red: 236/255, green: 229/255, blue: 206/255, alpha: 1)
        tipText.text = ""
        tipTitle.text = ""
        // Sets the size of the blur view to be equal to size of overall view
        blurView.bounds = self.view.bounds
        // Set width = 90% of the screen, height = 40% of the screen
        popUpView.bounds = CGRect (x: 0, y: 0, width: self.view.bounds.width*0.9, height: self.view.bounds.height*0.4)
        showCureent()
        setPassword()
        // Do any additional setup after loading the view.
    }
    
    // Initialize password
    func setPassword()
    {
        passWord = [Int]()
        for _ in 1..<5
        {
            passWord.append(Int.random(in: 1..<7))
        }
        print("Password: " + imageArray[passWord[0]] + " " + imageArray[passWord[1]] + " " +  imageArray[passWord[2]] + " " + imageArray[passWord[3]])
    }
    
    
    // Animate in a specified view
    func animateIn(desiredView:UIView)
    {
        let backgroundView = self.view
        // Attach our desired view to the screen (self .view/backgroundView)
        backgroundView?.addSubview(desiredView)
        // Sets the view's scaling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView!.center
        // animate the effect
        UIView.animate(withDuration: 0.3, animations:{
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    
    // Animate out a specified view
    func animateOut(desiredView: UIView)
    {
        UIView.animate(withDuration: 0.3, animations:{
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        },completion: { _ in
            desiredView.removeFromSuperview()
        })
    }
    
    func gameMonitor()
    {
        if gameStatus == 1
        {
            // Set up a reminder information and a alert
            let myAlert = UIAlertController(title: "Congratulation", message: "You win!", preferredStyle: UIAlertController.Style.alert)
            let yesAction = UIAlertAction(title: "Re-play", style: UIAlertAction.Style.default, handler: { ACTION in
                self.acc = 0
                self.guessHistory = [[Int]](repeating: [Int](repeating:0, count: 4),count:10)
                self.guessResultHistory = [[Int]](repeating: [Int](repeating:0, count: 4),count:10)
                //  Loop to delete each line
                for _ in 0...self.currentLine
                {
                    self.currentLine = self.currentLine - 1
                    self.myTable.deleteRows(at: [IndexPath(row: 0, section: 0)], with:  .fade)
                }
                self.gameStatus = 0
                self.setPassword()
            })
            myAlert.addAction(yesAction)
            self.present(myAlert,animated: true,completion: nil)
        }
        else if gameStatus == 2
        {
            // Set up a reminder information
            tipTitle.text = "Game Over"
            tipText.text = "You lost!See password!"
            rePlay.setTitle("Re-Play", for:  .normal)
            // Show password
            keyImage1.image=UIImage(named: imageArray[passWord[0]])
            keyImage2.image=UIImage(named: imageArray[passWord[1]])
            keyImage3.image=UIImage(named: imageArray[passWord[2]])
            keyImage4.image=UIImage(named: imageArray[passWord[3]])
            UserDefaults.standard.set(numbersOfLost, forKey: "numbersOfLost")
            animateIn(desiredView: blurView)
            animateIn(desiredView: popUpView)
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
