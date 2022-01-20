//
//  HomeTableViewCell.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 18/01/2022.
//

import UIKit
import Firebase

class HomeTableViewCell: UITableViewCell {
    
    let db = Firestore.firestore()
    let userid = Auth.auth().currentUser?.uid
    
    var userNameHome : UILabel = {
        $0.textColor = UIColor(named: "Color-2")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    var contentHome : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    var linkHome : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(contentHome)
        addSubview(linkHome)
        addSubview(userNameHome)
       
        setLablesConstraint()
       
    }
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    

    func setLablesConstraint(){
       
        
        userNameHome.topAnchor.constraint(equalTo: topAnchor , constant: 10).isActive = true
        userNameHome.heightAnchor.constraint(equalToConstant: 30)
        userNameHome.leftAnchor.constraint(equalTo: leftAnchor , constant: 10 ).isActive = true
         
        contentHome.topAnchor.constraint(equalTo: userNameHome.bottomAnchor , constant: 10).isActive = true
        contentHome.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contentHome.widthAnchor.constraint(equalToConstant: 350).isActive = true
        contentHome.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        linkHome.topAnchor.constraint(equalTo: contentHome.bottomAnchor , constant: 10).isActive = true
        linkHome.heightAnchor.constraint(equalToConstant: 30)
        linkHome.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
        
    }
    
}
