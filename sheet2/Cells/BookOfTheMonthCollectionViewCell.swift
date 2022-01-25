//
//  BookOfTheMonthCollectionViewCell.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 24/01/2022.
//

import UIKit

class BookOfTheMonthCollectionViewCell: UICollectionViewCell {
   
    var images : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIImageView())
    
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        addSubview(images)
        setConstraint()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    

    func setConstraint(){
        images.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        images.heightAnchor.constraint(equalToConstant: 100).isActive = true
        images.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }

    
}
