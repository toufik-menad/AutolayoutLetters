//
//  ViewController.swift
//  AutoLayoutLetters
//
//  Created by Toufik MENAD on 2018-03-27.
//  Copyright © 2018 Toufik MENAD. All rights reserved.
//

import UIKit

extension UIColor{
    static var pinkColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1 )
    
}

class ViewController: UIViewController {
    
    /* add my images here */
    private let letterImage : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "baa") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    /* add my text here */
    private let descriptionText : UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string:"Letter name goes here", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)] )
                attributedText.append(NSAttributedString(string:"\n\nthis is an appended text", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20) ]))
        textView.attributedText = attributedText

        textView.textAlignment = .center
        
        
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    /* add my buttons here */
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.pinkColor, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.pinkColor, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private let pageControl: UIPageControl = {
        let pc  = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .pinkColor
        pc.pageIndicatorTintColor = .gray
        return pc
    
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(descriptionText)
        setupBottmControls()
        setUpWelcome()
    }
    
    fileprivate func setupBottmControls(){
        let bottomControlsStackView = UIStackView(arrangedSubviews:[previousButton,pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)

        NSLayoutConstraint.activate([
            //previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    private func setUpWelcome(){
        
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .white
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topImageContainerView)
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // Add my letters here
        
        topImageContainerView.addSubview(letterImage)
        letterImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        letterImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        letterImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7).isActive = true
        letterImage.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.7).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        
        // Description
        descriptionText.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    


}

