//
//  HistoryViewController.swift
//  MasterMind v1
//
//  Created by Jason on 14/11/2021.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var win: UILabel!
    @IBOutlet weak var lose: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 236/255, green: 229/255, blue: 206/255, alpha: 1)
        // Calculating win rates and percentages
        win.text = "Win:" + String(numbersOfWin) + "   " + String(NumberFormatter.localizedString(from: NSNumber(value: Double(numbersOfWin)/Double(numbersOfWin+numbersOfLost)), number: .percent))
        lose.text = "Lose:" + String(numbersOfLost) + "   " + String(NumberFormatter.localizedString(from: NSNumber(value: Double(numbersOfLost)/Double(numbersOfWin+numbersOfLost)), number: .percent))
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
