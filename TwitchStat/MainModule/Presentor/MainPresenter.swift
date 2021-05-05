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
    //func lastRowVisble(row: Int)
    func setCell(cell: MainTableViewCell, forRow row: Int)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouteProtocol?
    var entityTopGamesGateway: EntityGatewayTopGamesProtocol?
    var topGames: TopGames?
    var countTopGames: Int = 0
    var cache = Cache<Int, TopGames>()
    
    
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
            if let id = self.topGames?.top[safe: row]?.game.id {
                let stringDisplay = "\(row)# \(id): \(nameGame)"
                //cell.display(gameName: nameGame)
                cell.display(gameName: stringDisplay)
                //print(nameGame)
            }
        } else {
            self.nextFetchTopGames()
            cell.waitLoading()
        }
    }
    
    
    func initTopGames() {
        self.fetchTopGames(offset: 0)
        /*entityTopGamesGateway?.fetchInitTopGames { [weak self] result in
            guard let self = self else { return }
            print("initTopGames: Limit: \(self.topGames?.limit), Offset: \(self.topGames?.offset)")
            DispatchQueue.main.async {
                switch result {
                case .success(let topGames):
                    self.topGames = topGames
                    self.setCountTopGames()
                    self.view?.success()
                    print("Return initTopGames: Limit: \(self.topGames?.limit), Offset: \(self.topGames?.offset)")
                case .failure(let error):
                    print("NetworkService Failure")
                    self.view?.failure(error: error)
                }
            }
        }*/
    }
    
    func nextFetchTopGames() {
        guard let limit = self.topGames?.limit else { return }
        let offset = self.topGames?.offset ?? 0
        let newOffset = offset + limit
        self.fetchTopGames(offset: newOffset)
        
        
        
    }
    
    private func fetchTopGames(offset: Int) {
        if let cached = cache[offset] {
            self.topGames = cached
            self.setCountTopGames()
            self.view?.success()
            print("Network cahced")
            return
        }
        
        entityTopGamesGateway?.fetchOffsetTopGames(offset: offset, complation: { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let topGames):
                    if self.topGames == nil {
                        self.topGames = topGames
                    } else if let top = topGames?.top {
                        self.topGames?.top.append(contentsOf: top)
                        self.topGames?.offset = offset
                    }
                    self.cache[offset] = self.topGames
                    self.setCountTopGames()
                    self.view?.success()
                case .failure(let error):
                    print("NetworkService Failure")
                    self.view?.failure(error: error)
                }
            }
            
        })
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
    
    /*func lastRowVisble(row: Int) {
        //print("Row: \(row)")
    }*/
    

    
}
