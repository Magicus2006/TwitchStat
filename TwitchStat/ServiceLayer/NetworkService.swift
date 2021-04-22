//
//  NetworkService.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 20.04.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getTopGames(complation: @escaping (Result<TopGames?, Error >) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func getTopGames(complation: @escaping (Result<TopGames?, Error>) -> ()) {
        let urlString = "https://api.twitch.tv/kraken/games/top?limit=20"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("sd4grh0omdj9a31exnpikhrmsu3v46", forHTTPHeaderField: "Client-ID")
        request.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        
        
        
        URLSession.shared.dataTask(with: request) { data, _, error in
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
