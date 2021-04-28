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
    var topGames: TopGames? { get set }
    init(view: MainViewProtocol, entityGateway: EntityGatewayProtocol, router: RouteProtocol)
    func getTopGames()
    func tapOnTheGemas(top: Top?)
    func lastRowVisble(row: Int)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouteProtocol?
    let entityGateway: EntityGatewayProtocol
    var topGames: TopGames?
    
    required init(view: MainViewProtocol, entityGateway: EntityGatewayProtocol, router: RouteProtocol) {
        self.view = view
        self.entityGateway = entityGateway
        self.router = router
        self.getTopGames()
    }
    
    func tapOnTheGemas(top: Top?) {
        router?.showDetail(top: top)
    }
    
    func getTopGames() {
        entityGateway.fetchTopGames { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let topGames):
                    self.topGames = topGames
                    //print("Total: \(self.topGames?.total)")
                    self.view?.success()
                case .failure(let error):
                    print("NetworkService Failure")
                    self.view?.failure(error: error)
                }
            }
        }
    }
    func lastRowVisble(row: Int) {
        print("Row: \(row)")
    }
    

    
}
