//
//  ViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 20/01/2022.
//

import UIKit

class ViewController: UIViewController {

    let label1 = UILabel()
            let imageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            imageView.image = UIImage(named: "sha")
            return imageView
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            view.addSubview(imageView)
            
            label1.frame = CGRect(x: 50, y: 100, width: 300, height: 100)
            label1.text = "قال ﷺ:{إِنْ قَامَتِ السَّاعَةُ وَفِي يَدِ أَحَدِكُمْ فَسِيلَةٌ،فَلْيَغْرِسْهَا}"
            label1.textAlignment = .center
            label1.textColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
            label1.numberOfLines = 2
            label1.font = .systemFont(ofSize: 20)
            view.addSubview(label1)
            
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            imageView.center = view.center
            // logo
            view.backgroundColor = .white
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.animate()
                
            })
        }
        
        // logo
        
        private func animate() {
            UIView.animate(withDuration: 2, animations: {
                let size = self.view.frame.size.width * 4
                let diffX = size - self.view.frame.size.width
                let diffY = self.view.frame.size.height - size
                self.imageView.frame = CGRect(
                    x: -(diffX/2),
                    y: diffY/2,
                    width: size,
                    height: size
                   
                    
                )
                self.imageView.alpha = 0
            })
            UIView.animate(withDuration: 1.5, animations: {
                self.label1.alpha = 0
            }, completion: { done in
                if done {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        let animationscreen = HomeViewController()
                        animationscreen.modalTransitionStyle = .crossDissolve
                        animationscreen.modalPresentationStyle = .fullScreen
                        self.present(animationscreen, animated: true)
                        
                    })
                }
            })
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
    

}
