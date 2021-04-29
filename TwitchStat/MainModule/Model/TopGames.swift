//
//  TopGames.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 21.04.2021.
//

import Foundation

// MARK: - TopGames
struct TopGames: Codable {
    let total: Int
    var limit = 40
    var offset = 0
    
    var top: [Top]

    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case top
    }
}

// MARK: - Top
struct Top: Codable {
    let channels, viewers: Int
    let game: Game
}

// MARK: - Game
struct Game: Codable {
    let id: Int
    let box: Box
    let giantbombID: Int
    let logo: Box
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case box
        case giantbombID = "giantbomb_id"
        case logo, name
    }
}

// MARK: - Box
struct Box: Codable {
    let large, medium, small: String
    let template: String
}
