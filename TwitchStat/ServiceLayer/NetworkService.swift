//
//  NetworkService.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 20.04.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchTopGames(complation: @escaping (Result<Data?, Error >) -> ())
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
    func fetchTopGames(limit: Int, offset: Int, complation: @escaping (Result<Data?, Error>) -> ()) {
        
    }
    
    deinit {
        print("NetworkService: deinit")
    }
    
    
}
