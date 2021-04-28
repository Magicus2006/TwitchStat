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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.topGames?.top.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let nameGame = presenter.topGames?.top[indexPath.row].game.name
        cell.textLabel?.text = nameGame
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let top = presenter.topGames?.top[indexPath.row]
        presenter.tapOnTheGemas(top: top)
    }
}

// MARK: UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let row = tableView.indexPathsForVisibleRows?.last?[1] {
            presenter.lastRowVisble(row: row)
        }
    }
}

// MARK: MainViewProtocol

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

