//
//  RecordCoordinator.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import UIKit

class RecordCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()

    lazy var recordVC : RecordViewController = {
        let vc = RecordViewController()
        vc.title = "Record"
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([recordVC], animated: false)
    }
    
    
}
