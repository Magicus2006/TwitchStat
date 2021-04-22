//
//  RouterProtocol.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 20.04.2021.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouteProtocol: RouterMain {
    func initialViewController()
    func showDetail(top: Top?)
    func popToRoot()
}

class Router: RouteProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard  let mainViewController = assemblyBuilder?.createMainModule(router: self)  else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(top: Top?) {
        if let navigationController = navigationController {
            guard  let detailViewController = assemblyBuilder?.createDetailModule(top: top, router: self)  else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
   
    
}
