//
//  ModuleBuilder.swift
//  MVP-LevelOne
//
//  Created by Даниил Тчанников on 29.06.2023.
//

import UIKit

protocol AsselderBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(comment: Comment, router: RouterProtocol) -> UIViewController
}

class AsselderModelBuilder: AsselderBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createDetailModule(comment: Comment, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
        view.presenter = presenter
        
        return view
    }
}
