//
//  VideoCoordinator.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import UIKit

class VideoCoordinator: Coordinator  {
    var rootViewController =  UINavigationController()
    lazy var videoVC : VideoViewController = {
        let vc = VideoViewController()
        vc.title = "Video"
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([videoVC], animated: false)
    }
    
    
}
