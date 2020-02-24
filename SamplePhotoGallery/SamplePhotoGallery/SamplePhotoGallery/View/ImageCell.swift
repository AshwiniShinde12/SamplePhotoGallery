//
//  ImageCell.swift
//  SamplePhotoGallery
//
//  Created by Ashwini on 23/02/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//
import UIKit

class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        contentView.addSubview(imageView)
   
        label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        let widthConstraint = NSLayoutConstraint(item: label!, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentView.frame.size.width)

        let heightConstraint = NSLayoutConstraint(item: label!, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)

        let xConstraint = NSLayoutConstraint(item: label!, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0)

        let bConstraint = NSLayoutConstraint(item: label!, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, bConstraint])

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = imageView.frame
        frame.size.height = self.frame.size.height
        frame.size.width = self.frame.size.width
        frame.origin.x = 0
        frame.origin.y = 0
        imageView.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
