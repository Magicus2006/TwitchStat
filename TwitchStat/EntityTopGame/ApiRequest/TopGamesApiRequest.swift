//
//  TopGamesApiRequest.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 27.04.2021.
//

import Foundation

class TopGamesApiRequest: GeneralApiRequest, ApiRequestProtocol {
    var urlRequest: URLRequest {
        let limit: Int = 40
        let offset: Int = 0
        let url: URL! = URL(string: "\(baseUrl)/top?limit=\(limit)&offset=\(offset)")
        var request = URLRequest(url: url)
        
        request.setValue("sd4grh0omdj9a31exnpikhrmsu3v46", forHTTPHeaderField: "Client-ID")
        request.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "GET"
        
        return request
    }
}
