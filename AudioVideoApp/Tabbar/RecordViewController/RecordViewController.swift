//
//  RecordViewController.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import UIKit
import AVFoundation
import SnapKit

class RecordViewController: UIViewController {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var numOfRecords = 0
    
    
    private lazy var recordButton: UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "record.circle"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(didRecordButton), for: .touchUpInside)
        return button
    } ()
    
    private lazy var playButton: UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        
        button.tintColor = .white
        button.addTarget(self, action: #selector(didPlayButton), for: .touchUpInside)
        return button
    } ()
    
    
    private lazy var tableRecords: UITableView = {
        let table = UITableView ()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Custom Cell")
        return table
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        //settion of session
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number : Int = UserDefaults.standard.object(forKey: "myNum") as? Int {
            numOfRecords = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { hasPermission in
            if hasPermission {
                print("ACCEPTED")
            }
        }
        setLayers()
    }
    
    
    
    private func  setLayers() {
        self.view.addSubview(recordButton)
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(recordButton.snp.height)
        }
        
        self.view.addSubview(tableRecords)
        tableRecords.snp.makeConstraints { make in
            make.top.equalTo(recordButton.snp.bottom).offset(50)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        self.view.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.centerY.equalTo(recordButton.snp.centerY)
            make.trailing.equalTo(recordButton.snp.leading).offset(-30)
        }
        
    }
    
    
    @objc private func didPlayButton () {
        audioPlayer.stop()
    }
    
    
    @objc private func didRecordButton () {
        if audioRecorder == nil {
            numOfRecords += 1
            print(numOfRecords)
            
            let filename = getDirectry().appendingPathComponent("\(numOfRecords).m4a")
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            do {
                audioRecorder = try AVAudioRecorder(url:filename , settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                recordButton.setImage(UIImage(systemName: "record.circle.fill"), for: .normal)
            }
            
            catch {
                displayAlert(title: "Ups!", message: "Recording failed")
            }
        } else {
            // stop audio recording
            audioRecorder.stop()
            
            audioRecorder = nil
            
            UserDefaults.standard.set(numOfRecords, forKey: "myNum")
            tableRecords.reloadData()
            recordButton.setImage(UIImage(systemName: "record.circle"), for: .normal)
        }
    }
    
    
}


extension RecordViewController: AVAudioRecorderDelegate {
    // function that gets path to derectry
    
    func getDirectry() -> URL {
        let paths = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    // function that displays an allert
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default))
        self.present(alert, animated: true)
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfRecords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom Cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectry().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
        }
        catch {
            print("Error")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
