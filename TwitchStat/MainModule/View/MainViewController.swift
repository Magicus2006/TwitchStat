//
//  ViewController.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 15.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - IBAction
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.topGames?.top.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let nameGame = presenter.topGames?.top[indexPath.row].game.name
            //presenter.comments?[indexPath.row]
        cell.textLabel?.text = nameGame
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            //let detaiViewController = AssemblyModuleBuilder.createDetailModule(comment: comment)
            //navigationController?.pushViewController(detaiViewController, animated: true)
        
        //let comment = presenter.comments?[indexPath.row]
        let top = presenter.topGames?.top[indexPath.row]
        presenter.tapOnTheComment(top: top)
    }
}  

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

