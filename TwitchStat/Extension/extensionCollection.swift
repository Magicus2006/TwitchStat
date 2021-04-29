//
//  extensionCollection.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 29.04.2021.
//

import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
