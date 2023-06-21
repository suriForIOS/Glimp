//
//  HomeRouter.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import UIKit

class HomeRouter {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        let viewController = HomeViewController()
        let presenter: HomeViewOutput & HomeInteractorOutput = HomePresenter()
        viewController.output = presenter
        viewController.output?.view = viewController
        viewController.output?.interactor = HomeInteractor()
        viewController.output?.interactor?.output = presenter
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
