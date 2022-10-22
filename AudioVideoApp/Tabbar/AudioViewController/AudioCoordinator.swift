//
//  AudioCoordinator.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import Foundation
import UIKit

class AudioCoordinator: Coordinator {
    var rootViewController = UINavigationController()
    lazy var audioVC : AudioViewController = {
        let vc = AudioViewController()
        vc.title = "Audio"
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([audioVC], animated: false)
    }
    
}
