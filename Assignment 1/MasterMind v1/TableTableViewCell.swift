//
//  TableTableViewCell.swift
//  MasterMind v1
//
//  Created by Jason on 29/10/2021.
//

import UIKit

class TableTableViewCell: UITableViewCell {

    @IBOutlet weak var firstGuessImage: UIImageView!
    @IBOutlet weak var secondGuessImage: UIImageView!
    @IBOutlet weak var thirdGuessImage: UIImageView!
    @IBOutlet weak var fourthGuessImage: UIImageView!
    @IBOutlet weak var guessResult1: UIImageView!
    @IBOutlet weak var guessResult2: UIImageView!
    @IBOutlet weak var guessResult3: UIImageView!
    @IBOutlet weak var guessResult4: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
