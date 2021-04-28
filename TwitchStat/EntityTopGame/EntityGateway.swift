//
//  EntityGateway.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 27.04.2021.
//

import Foundation

protocol EntityGatewayProtocol {
    init(networkService: NetworkServiceProtocol)
    func fetchTopGames(complation: @escaping (Result<TopGames?, Error>) -> ())
}

class EntityGateway: EntityGatewayProtocol {
    
    let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTopGames(complation: @escaping (Result<TopGames?, Error>) -> ()) {
        networkService.fetchTopGames { (result) in
            switch result {
            case .success(let topGame):
                complation(.success(topGame))
                
            case .failure(let error):
                complation(.failure(error))
            }
            //complation(result)
        }
    }
}
