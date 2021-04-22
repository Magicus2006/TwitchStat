//
//  MainPresenter.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 15.04.2021.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
    
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, dbTopGames: DBTopGamesProtocol, router: RouteProtocol)
    func getComments()
    var topGames: TopGames? { get set }
    func tapOnTheComment(top: Top?)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouteProtocol?
    let networkService: NetworkServiceProtocol!
    let dbTopGames: DBTopGamesProtocol!
    var topGames: TopGames?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, dbTopGames: DBTopGamesProtocol, router: RouteProtocol) {
        self.view = view
        self.networkService = networkService
        self.dbTopGames = dbTopGames
        self.router = router
        getComments()
    }
    func tapOnTheComment(top: Top?) {
        router?.showDetail(top: top)
    }
    
    func getComments() {
        networkService.getTopGames { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let topGames):
                    self.topGames = topGames
                    self.dbTopGames.saveTopGames(topGames: topGames)
                    self.view?.success()
                case .failure(let error):
                    print("NetworkService Failure")
                    self.topGames = self.dbTopGames.loadTopGames()
                    self.view?.success()
                    //self.view?.failure(error: error)
                }
            }
        }
    }
    

    
}
