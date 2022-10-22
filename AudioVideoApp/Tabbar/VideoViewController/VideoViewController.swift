//
//  VideoViewController.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 19/10/22.
//

import UIKit
import SnapKit
import AVKit

class VideoViewController: UIViewController, UICollectionViewDataSource {
    
    let cuncurrentQueue = DispatchQueue(label: "com.app.concurrent", attributes: [.concurrent])
    
    private lazy var collectionLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout ()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset =  UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    } ()

    
    private lazy var videoCollection: UICollectionView  = {
        let  collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "VideoCollectionViewCell")
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(videoCollection)
        videoCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension VideoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        linkArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        DispatchQueue.main.async {
            cell.setupCell(index: indexPath.row)
        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let itemWidth = collectionView.bounds.width - 32
        let itemHeight = itemWidth * 0.56
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WatchVideoViewController()
        vc.videoID = linkArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

