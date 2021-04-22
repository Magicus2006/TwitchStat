//
//  DetailViewController.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 20.04.2021.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: IBoutlet
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var channalCountLabel: UILabel!
    @IBOutlet weak var viewersCountLabel: UILabel!
    @IBOutlet weak var logoGamesImage: UIImageView!
    
    
    var presenter: DetailViewPresentorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setComment()
    }
    /*@IBAction func tapAction(_ sender: Any) {
        presenter.tap()
    }*/
    
}

extension DetailViewController: DetailViewProtocol {
    func setComment(top: Top?) {
        gameLabel.text = top?.game.name
        channalCountLabel.text = String(top?.channels ?? 0)
        viewersCountLabel.text = String(top?.viewers ?? 0)
        if let url = URL(string: top?.game.logo.medium ?? "") {
            logoGamesImage.load(url: url)
        }
        
        //commentLable.text = comment?.body
        
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
