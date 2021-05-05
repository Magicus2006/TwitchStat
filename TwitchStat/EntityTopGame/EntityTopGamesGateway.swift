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
    func fetchOffsetTopGames(offset: Int, complation: @escaping (Result<TopGames?, Error>) -> ())
}

class EntityTopGamesGateway: EntityGatewayTopGamesProtocol {
    
    let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchInitTopGames(complation: @escaping (Result<TopGames?, Error>) -> ()) {
        fetchOffsetTopGames(offset: 0,complation: complation)
        /*networkService.fetchTopGames { (result) in
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
        }*/
    }

    func fetchOffsetTopGames(offset: Int, complation: @escaping (Result<TopGames?, Error>) -> ()) {
        networkService.fetchOffsetTopGames(offset: offset) { (result) in
            let cache = NSCache<NSNumber, TopGames>()
            switch result {
            case .success(let data):
                print("Network get")
                do {
                    let obj = try JSONDecoder().decode(TopGames.self, from: data!)
                    cache.setObject(obj, forKey: NSNumber(integerLiteral: offset))
                    complation(.success(obj))
                } catch {
                    complation(.failure(error))
                }
            case .failure(let error):
                print("Not network get")
                if let cachedVersion = cache.object(forKey: NSNumber(integerLiteral: offset)) {
                    // use the cached version
                    let obj = cachedVersion
                    complation(.success(obj))
                } else {
                    complation(.failure(error))
                }
            }
        }
    }

    
    deinit {
        print("deinit EntityTopGamesGateway")
    }
}
