//
//  NetworkService.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 20.04.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchTopGames(complation: @escaping (Result<TopGames?, Error >) -> ())
}



protocol ApiRequestProtocol {
    var urlRequest: URLRequest { get }
}






class NetworkService: NetworkServiceProtocol {
    func fetchTopGames(complation: @escaping (Result<TopGames?, Error>) -> ()) {
       
        let topGamesApiRequest = TopGamesApiRequest()
        
        URLSession.shared.dataTask(with: topGamesApiRequest.urlRequest) { data, _, error in
            if let error = error {
                complation(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(TopGames.self, from: data!)
                complation(.success(obj))
            } catch {
                complation(.failure(error))
            }
        }.resume()
    }
    
    
    
}
