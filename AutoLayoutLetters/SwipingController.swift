//
//  SwipingController.swift
//  AutoLayoutLetters
//
//  Created by Toufik MENAD on 2018-03-28.
//  Copyright © 2018 Toufik MENAD. All rights reserved.
//

import UIKit
import AVFoundation

class SwipingController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var audioPlayer: AVAudioPlayer!
    var pageImageName: String!
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: {
            (_) in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }){
            (_) in
        }
        
        
    }
    
    
 
    
    let pages = [
        Page(imageName:"alif" , headerText:"test1", audioFile: "alif" ),
        Page(imageName:"haa" , headerText:"ها", audioFile: "baa" ),
        Page(imageName:"Artboard 8" , headerText:"test2", audioFile: "baa" ),
        Page(imageName:"Artboard 9" , headerText:"test3" , audioFile: "alif"),
        Page(imageName:"Artboard 10" , headerText:"test4" , audioFile: "alif"),
        Page(imageName:"Artboard 11" , headerText:"test5" , audioFile: "alif"),
    ]
    
    
    /* add my text here */
    private let descriptionText : UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    func setText(_: UITextView){
        descriptionText.text = pages[pageControl.currentPage].headerText
    }
    
    /* add my buttons here */
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.pinkColor, for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside )
        
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.pinkColor, for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
    
    // Description
    func addDescription(){
    view.addSubview(descriptionText)
    descriptionText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
    descriptionText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
    descriptionText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
    descriptionText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    
    /*Set up the function to play the audio file*/
    @objc private func play(){
        
        let fileName = pages[pageControl.currentPage].audioFile
        let URL = Bundle.main.url(forResource: fileName, withExtension: "aifc")

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL!)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }catch let error as NSError {
                print(error.debugDescription)
            }

    }
    
    @objc private func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        play()
        
    }
    

    
    @objc private func handlePrevious(){
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        play()
        
    }
    
 
    private lazy var  pageControl: UIPageControl = {
        let pc  = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .pinkColor
        pc.pageIndicatorTintColor = .gray
        return pc
        
    }()
    
    
    fileprivate func setupBottmControls(){
        let bottomControlsStackView = UIStackView(arrangedSubviews:[previousButton,pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int (x / view.frame.width)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottmControls()
        addDescription()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell .self, forCellWithReuseIdentifier: "cellId" )
        collectionView?.isPagingEnabled = true
        collectionView?.isUserInteractionEnabled = true
    }
    
    
    override func collectionView(_ _collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item ]
        cell.page = page
        setText(_:descriptionText)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
