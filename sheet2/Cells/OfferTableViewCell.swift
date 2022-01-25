//
//  OfferTableViewCell.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 20/01/2022.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    
    var nameLabel: UILabel = {
        $0.textColor = UIColor(named: "Color-1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
//    var contentText : UITextView = {
//        $0.isEditable = false
//        $0.textColor = UIColor(named: "Color-1")
//        $0.backgroundColor = UIColor(named: "Color")
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.font = UIFont(name: "Arial-Bold", size: 30)
//
//        return $0
//    }(UITextView())
    
    var contentText : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIImageView())
    
    
    
    var endOfferLabel : UILabel = {
        $0.textColor = UIColor(named: "Color-1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(contentText)
        addSubview(endOfferLabel)
        addSubview(nameLabel)
       
        setLablesConstraint()
       
    }
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    

    func setLablesConstraint(){
       
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor , constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30)
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
         
        contentText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor , constant: 10).isActive = true
        contentText.heightAnchor.constraint(equalToConstant: 200).isActive = true
        contentText.widthAnchor.constraint(equalToConstant: 350).isActive = true
        contentText.bottomAnchor.constraint(equalTo: endOfferLabel.topAnchor).isActive = true
        contentText.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
         
        endOfferLabel.topAnchor.constraint(equalTo: contentText.bottomAnchor , constant: 10).isActive = true
        endOfferLabel.heightAnchor.constraint(equalToConstant: 30)
        endOfferLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
        
    }
    

}
