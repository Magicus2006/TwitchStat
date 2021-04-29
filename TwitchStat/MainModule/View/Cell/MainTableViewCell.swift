//
//  MainTableViewCell.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 29.04.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"

    @IBOutlet weak var gamesNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    static func nib() -> UINib {
        return  UINib(nibName: "MainTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(gameName: String) {
        activityIndicator.isHidden = true
        gamesNameLabel.text = gameName
    }
    
    func waitLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        gamesNameLabel.isHidden = true
    }
    
    
}
