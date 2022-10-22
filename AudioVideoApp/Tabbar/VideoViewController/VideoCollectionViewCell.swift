//
//  VideoCollectionViewCell.swift
//  AudioVideoApp
//
//  Created by Kiryl Rakk on 21/10/22.
//

import UIKit
import YouTubeiOSPlayerHelper

class VideoCollectionViewCell: UICollectionViewCell {
    
    private lazy var view: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCell (index: Int) {
        print(index)
        view.image = UIImage(named: "\(index)")
    }
    
    
}
