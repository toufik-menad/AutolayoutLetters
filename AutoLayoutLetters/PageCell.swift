//
//  PageCell.swift
//  AutoLayoutLetters
//
//  Created by Toufik MENAD on 2018-03-28.
//  Copyright © 2018 Toufik MENAD. All rights reserved.
//

import UIKit
import AVFoundation

class PageCell: UICollectionViewCell {
    
    
    
    
    let backgroundUiview = UIColor(red: 250/255, green: 165/255, blue: 25/255, alpha: 1)
    
    
    var page: Page? {
        didSet{
            guard let unwrappedPage = page else {return}
            letterImage.image = UIImage(named: unwrappedPage.imageName)
        }
    }
     
    /* add my images here */
    private let letterImage : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "baa") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = backgroundUiview
        setUpWelcome()
    }
    
    
    private func setUpWelcome(){
        
        let topImageContainerView = UIView()
//        let width = topImageContainerView.widthAnchor
//        let height = topImageContainerView.heightAnchor
        topImageContainerView.backgroundColor = .red
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topImageContainerView)
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        // Add my letters here
        
        topImageContainerView.addSubview(letterImage)
        letterImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        letterImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        letterImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.6).isActive = true
        letterImage.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.6).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
