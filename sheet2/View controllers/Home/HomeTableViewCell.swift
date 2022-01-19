//
//  HomeTableViewCell.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 18/01/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var userNameHome : UIButton = {
//        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIButton())
    
    var contentHome : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    var linkHome : UIButton = {
        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIButton())
    var bookmark : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "bookmark"), for: .normal)
        
        
        return $0
    }(UIButton())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(userNameHome)
        addSubview(contentHome)
        addSubview(linkHome)
        addSubview(bookmark)
       
        setLablesConstraint()
       
    }
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    func setLablesConstraint(){
        
//        userNameHome.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//        userNameHome.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//        userNameHome.widthAnchor.constraint(equalToConstant: 80),
//        userNameHome.heightAnchor.constraint(equalToConstant: 50),
//
//        contentHome.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//        contentHome.topAnchor.constraint(equalTo: userNameHome.bottomAnchor, constant: 10),
//        contentHome.widthAnchor.constraint(equalToConstant: 200),
//        contentHome.heightAnchor.constraint(equalToConstant: 100)
//
//
//        linkHome.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
       
        
        userNameHome.topAnchor.constraint(equalTo: topAnchor , constant: 10).isActive = true
        userNameHome.heightAnchor.constraint(equalToConstant: 30)
        userNameHome.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true// constant will change
         
        contentHome.topAnchor.constraint(equalTo: userNameHome.bottomAnchor , constant: 10).isActive = true
        contentHome.heightAnchor.constraint(equalToConstant: 30)
        contentHome.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
         
        linkHome.topAnchor.constraint(equalTo: contentHome.bottomAnchor , constant: 10).isActive = true
        linkHome.heightAnchor.constraint(equalToConstant: 30)
        linkHome.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
        
        bookmark.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        bookmark.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
//        bookmark.widthAnchor.constraint(equalToConstant: 35),
        bookmark.heightAnchor.constraint(equalToConstant: 70)
    }

}
