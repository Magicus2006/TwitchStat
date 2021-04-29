//
//  EntityGateway.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 27.04.2021.
//

import Foundation

protocol EntityGatewayTopGamesProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol)
    func fetchInitTopGames(complation: @escaping (Result<TopGames?, Error>) -> ())
}

class EntityTopGamesGateway: EntityGatewayTopGamesProtocol {
    
    let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchInitTopGames(complation: @escaping (Result<TopGames?, Error>) -> ()) {
        networkService.fetchTopGames { (result) in
            switch result {
            case .success(let data):
                do {
                    let obj = try JSONDecoder().decode(TopGames.self, from: data!)
                    complation(.success(obj))
                } catch {
                    complation(.failure(error))
                }
            case .failure(let error):
                complation(.failure(error))
            }
            //complation(result)
        }
    }
    

    
    deinit {
        print("deinit EntityTopGamesGateway")
    }
}
