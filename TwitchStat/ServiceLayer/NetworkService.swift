//
//  NetworkService.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 20.04.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchTopGames(complation: @escaping (Result<Data?, Error >) -> ())
    func fetchOffsetTopGames(offset: Int, complation: @escaping (Result<Data?, Error>) -> ())
}



protocol ApiRequestProtocol {
    var urlRequest: URLRequest { get }
}






class NetworkService: NetworkServiceProtocol {
    func fetchTopGames(complation: @escaping (Result<Data?, Error>) -> ()) {
        
        let topGamesApiRequest = TopGamesApiRequest()
        
        URLSession.shared.dataTask(with: topGamesApiRequest.urlRequest) { data, _, error in
            if let error = error {
                complation(.failure(error))
                return
            }
            complation(.success(data))
        }.resume()
    }
    
    func fetchOffsetTopGames(offset: Int, complation: @escaping (Result<Data?, Error>) -> ()) {
        let topGamesApiRequest = TopGamesApiRequest(offset: offset)
        
        URLSession.shared.dataTask(with: topGamesApiRequest.urlRequest) { data, _, error in
            if let error = error {
                complation(.failure(error))
                return
            }
            complation(.success(data))
        }.resume()
    }
    
    deinit {
        print("NetworkService: deinit")
    }
    
    
}
