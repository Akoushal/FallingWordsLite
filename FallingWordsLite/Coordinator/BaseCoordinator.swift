//
//  BaseCoordinator.swift
//  FallingWordsLite
//
//  Created by Koushal, KumarAjitesh on 2020/07/06.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

final class BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() -> UIViewController {
        return configureViewController()
    }
    
    //MARK: - Private methods
    
    /// - Returns: Instance of ViewController
    private func configureViewController() -> ViewController {
        return ViewController()
    }
}
