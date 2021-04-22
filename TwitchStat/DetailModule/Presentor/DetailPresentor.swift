//
//  DetailPresentor.swift
//  TwitchStat
//
//  Created by Дмитрий Кондратьев on 20.04.2021.
//

import Foundation
 
protocol DetailViewProtocol: class {
    func setComment(top: Top?)
}

protocol DetailViewPresentorProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouteProtocol, top: Top?)
    func setComment()
    func tap()
}


class DetailPresentor: DetailViewPresentorProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var top: Top?
    var router: RouteProtocol?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol,router: RouteProtocol, top: Top?) {
        self.view = view
        self.networkService = networkService
        self.top = top
        self.router = router
    }
    func tap() {
        router?.popToRoot()
    }
    
    
    public func setComment() {
        self.view?.setComment(top: top)
    }
    
    
}
