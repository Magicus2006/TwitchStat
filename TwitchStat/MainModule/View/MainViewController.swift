//
//  ViewController.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 15.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifier)
    }

}
// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countTopGames
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        presenter.setCell(cell: cell, forRow: indexPath.row)
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapOnTheGemas(forRow: indexPath.row)
    }
}

/*// MARK: UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let row = tableView.indexPathsForVisibleRows?.last?[1] {
            presenter.lastRowVisble(row: row)
        }
    }*/
}*/

// MARK: MainViewProtocol

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

