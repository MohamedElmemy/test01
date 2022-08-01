//
//  inboardingViewController.swift
//  new02
//
//  Created by Ahmed Elmemy on 29/07/2022.
//

import UIKit

class inboardingViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var Nextbtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var slides : [onboardingSlide] = []
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                Nextbtn.setTitle("Get Started", for: .normal)
            }else {
                Nextbtn.setTitle("Next", for: .normal)
            }
        }
    }
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [onboardingSlide(image: UIImage(named: "Image1")! , description: "image1") ,
                  onboardingSlide(image: UIImage(named: "Image2")!, description: "image2") ,
                  onboardingSlide(image: UIImage(named: "Image3")!, description: "image3") ,
                  onboardingSlide(image: UIImage(named: "Image4")!, description: "image4") ,
                  onboardingSlide(image: UIImage(named: "Image5")!, description: "image5")
        ]

    }
    
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
//            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }else{
            
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
   
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! onboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }


}
