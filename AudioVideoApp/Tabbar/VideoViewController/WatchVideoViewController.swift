//
//  WatchVideoViewController.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 21/10/22.
//

import UIKit
import YouTubeiOSPlayerHelper
import WebKit

class WatchVideoViewController: UIViewController {
    
    var videoID : String?
    private var playerView = YTPlayerView()
    let cuncurrentQueue = DispatchQueue(label: "com.app.concurrent", attributes: [.concurrent])
    
    var video: UIView = {
        let video = YTPlayerView ()
        return video
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        setLayers()
        
        playerView.delegate = self
        
        if let id = self.videoID {
            self.playerView.load(withVideoId: "\(id)", playerVars: ["playsinline": "1"])
            self.playerView.playVideo()
        }
    }
    
    
    private func setLayers() {
        self.view.addSubview(self.video)
        
        video.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(self.view.bounds.width).multipliedBy(0.53)
        }
        
        
        video.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

