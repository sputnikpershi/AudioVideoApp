//
//  AudioViewController.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import UIKit
import SnapKit
import AVFoundation


class AudioViewController: UIViewController {
    
    var player: AVAudioPlayer!
    private var position = 0
    
    private lazy var songLabel: UILabel = {
       let label = UILabel()
        label.text = "Song"
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var playButton: UIButton  =  {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(tapPlayButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton  =  {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(tapStopButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton  =  {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(tapNextButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var previousButton: UIButton  =  {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(tapPreviousButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        setLayers()
        playerConfigure()
    }
    
    
    private func  setLayers() {
     
        self.view.addSubview(self.playButton)
        playButton.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.center.equalToSuperview()
        }
        
        
        self.view.addSubview(self.songLabel)
        songLabel.snp.makeConstraints { make in
            make.bottom.equalTo(playButton.snp.top).offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        self.view.addSubview(self.stopButton)
        stopButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.equalTo(playButton.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.previousButton)
        previousButton.snp.makeConstraints { make in
            make.height.width.equalTo(stopButton.snp.height)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(playButton.snp.leading).offset(-16)
            
        }
        
        self.view.addSubview(self.nextButton)
        nextButton.snp.makeConstraints { make in
            make.height.width.equalTo(stopButton.snp.height)
            make.centerY.equalToSuperview()
            make.leading.equalTo(playButton.snp.trailing).offset(16)
        }
    }
    
    
    private func playerConfigure () {
        
        do {
            try  AVAudioSession.sharedInstance().setCategory(.playback)
            try  AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            let urldString = Bundle.main.path(forResource: songs[position], ofType: "mp3")
            guard let urldString = urldString else { return }
            player = try AVAudioPlayer(contentsOf: (URL(fileURLWithPath: urldString)))
        }
        catch {
            print("something went wrong")
        }

        
    }
    
    
    
    
    @objc private func tapPlayButtonAction () {
        
        if let player = player, player.isPlaying {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
        } else {
            //set up playes and play
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            songLabel.text = songs[position]
//            playerConfigure()
            player?.play()
            }
        }
    
    @objc private func tapStopButtonAction () {
        if let player = player, player.isPlaying {
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.stop()
        }
    }
    
    @objc private  func tapNextButtonAction () {
       
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        if position  < 4 {
            position += 1
        } else {
            position = 0
        }
        songLabel.text = songs[position]
        player?.stop()
        playerConfigure()


    }
    
    
    @objc private  func tapPreviousButtonAction () {
        self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        
        if position  > 0 {
            position -= 1
        } else {
            position = songs.count - 1
        }
        songLabel.text = songs[position]
        player?.stop()
        playerConfigure()

    }
    
    
    
}
