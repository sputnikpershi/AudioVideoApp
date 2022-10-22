//
//  AppCoordinator.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        childCoordinators = [mainCoordinator]
        window.rootViewController = mainCoordinator.rootViewController
    }
    
    
}
