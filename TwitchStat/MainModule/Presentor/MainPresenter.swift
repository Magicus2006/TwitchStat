//
//  MainPresenter.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 15.04.2021.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    
    
}

protocol MainViewPresenterProtocol: AnyObject {
    var topGames: TopGames? { get set }
    var countTopGames: Int { get }
    init(view: MainViewProtocol, entityTopGamesGateway: EntityGatewayTopGamesProtocol, router: RouteProtocol)
    func initTopGames()
    func tapOnTheGemas(forRow row: Int)
    func lastRowVisble(row: Int)
    func setCell(cell: MainTableViewCell, forRow row: Int)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouteProtocol?
    var entityTopGamesGateway: EntityGatewayTopGamesProtocol?
    var topGames: TopGames?
    var countTopGames: Int = 0
    
    
    required init(view: MainViewProtocol, entityTopGamesGateway: EntityGatewayTopGamesProtocol, router: RouteProtocol) {
        self.view = view
        self.entityTopGamesGateway = entityTopGamesGateway
        self.router = router
        self.initTopGames()
    }
    
    func tapOnTheGemas(forRow row: Int) {
        let top = self.topGames?.top[safe: row]
        router?.showDetail(top: top)
    }
    
    func setCell(cell: MainTableViewCell, forRow row: Int) {
        if let nameGame = topGames?.top[safe: row]?.game.name {
            cell.display(gameName: nameGame)
        } else {
            cell.waitLoading()
        }
    }
    
    
    func initTopGames() {
        entityTopGamesGateway?.fetchInitTopGames { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let topGames):
                    self.topGames = topGames
                    self.setCountTopGames()
                    self.view?.success()
                case .failure(let error):
                    print("NetworkService Failure")
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    
    
    private func setCountTopGames() {
        if let count = self.topGames?.top.count {
            if count == self.topGames?.total {
                self.countTopGames = count
            } else if count < self.topGames?.total ?? 0 {
                self.countTopGames = count + 1
            } else {
                self.countTopGames = 0
            }
        }
    }
    
    func lastRowVisble(row: Int) {
        //print("Row: \(row)")
    }
    

    
}
