//
//  MainCoordinator.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import UIKit


class MainCoordinator: Coordinator {
    
    var rootViewController = UITabBarController()
    
    var childCoordinators = [Coordinator]()
    
    init() {
        rootViewController.tabBar.backgroundColor = .white
    }
    
    
    func start() {
        
        
        let audioCoordinator = AudioCoordinator()
        audioCoordinator.start()
        childCoordinators.append(audioCoordinator)
        let audioVC = audioCoordinator.rootViewController
        audioVC.tabBarItem = UITabBarItem(title: "Music", image: UIImage(systemName: "camera"), selectedImage: UIImage(systemName: "music.quarternote.3"))


        let videoCoordinator = VideoCoordinator()
        videoCoordinator.start()
        childCoordinators.append(videoCoordinator)
        let videoVC = videoCoordinator.rootViewController
        videoVC.tabBarItem = UITabBarItem(title: "Video", image: UIImage(systemName: "play.rectangle"), selectedImage: UIImage(systemName: "play.rectangle.fill"))

        let recordCoordinator = RecordCoordinator()
        recordCoordinator.start()
        childCoordinators.append(recordCoordinator)
        let recordVC = recordCoordinator.rootViewController
        recordVC.tabBarItem = UITabBarItem(title: "Record", image: UIImage(systemName: "record.circle"), selectedImage: UIImage(systemName: "record.circle.fill"))

        
        
        self.rootViewController.viewControllers = [audioVC, videoVC, recordVC]
        
        
    }
    
    
}
