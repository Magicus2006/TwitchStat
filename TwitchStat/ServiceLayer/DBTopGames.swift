//
//  CoreData.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 21.04.2021.
//

import UIKit
import CoreData


protocol DBTopGamesProtocol {
    func saveTopGames(topGames: TopGames?)
    func loadTopGames() -> TopGames?
}

class DBTopGames: DBTopGamesProtocol {
    func loadTopGames() -> TopGames? {
        var topGames: TopGames?
        
        if let appDelegete = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegete.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<TopGamesEntity>(entityName: "TopGamesEntity")
            
            do {
                let tops = try context.fetch(fetchRequest)
                
                for top in tops {
                    let box = Box(large: "", medium: "", small: "", template: "")
                    //var game = Game(id: top.id, box: box, giantbombID: 1, logo: box, name: top.name)
                    let game = Game(id: Int(top.id), box: box, giantbombID: 1, logo: box, name: top.name ?? "")
                    topGames?.top.append(Top(channels: Int(top.channels), viewers: Int(top.viewers), game: game))
                }
            } catch {
                    print("Error Load")
            }
        }
        
        return topGames
    }
    
    func saveTopGames(topGames: TopGames?) {
        if let tops = topGames?.top {
            if tops.count > 0 {
                for top in tops {
                    saveGameInfo(top: top)
                }
            }
        }
        
    }
    
    private func saveGameInfo(top: Top?) {
        if let appDelegete = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegete.persistentContainer.viewContext
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "TopGamesEntity", in: context) else {
                return
            }
            
            let gameValue = NSManagedObject(entity: entityDescription, insertInto: context)
            if let top = top {
                gameValue.setValue(top.game.id, forKey: "id")
                gameValue.setValue(top.game.name, forKey: "name")
                gameValue.setValue(top.channels, forKey: "channels")
                gameValue.setValue(top.viewers, forKey: "viewers")
                //gameValue.setValue(top.game.logo.medium, forKey: "urlImage")
            }
            
            do {
                try context.save()
                print("Saved: \(String(describing: top?.game.name))")
            } catch {
                print("saving Error")
            }
            //let topGamesEntity = TopGamesEntity(context: context)
        
            //let barCodeHistory = BarCodeHistory(context: context)
        
            // barCodeHistory.typeBarCode = type
            //barCodeHistory.barCode = code
            //barCodeHistory.createDate = Date()
        
            //myDelegete.saveContext()
        }
    }
    
    
}
