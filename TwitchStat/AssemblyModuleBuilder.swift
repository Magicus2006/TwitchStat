//
//  ModuleBuilder.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 15.04.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouteProtocol) -> UIViewController
    func createDetailModule(top: Top?, router: RouteProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
   
    func createMainModule(router: RouteProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let dbTopGames = DBTopGames()
        let presenter = MainPresenter(view: view, networkService: networkService, dbTopGames: dbTopGames, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(top: Top?, router: RouteProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresentor(view: view, networkService: networkService, router: router, top: top)
        view.presenter = presenter
        return view
    }
    
     
}
