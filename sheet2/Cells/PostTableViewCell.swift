//
//  PostTableViewCell.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 05/01/2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    var contentPost = UILabel()
    var usernamePoster = UILabel()
    var linkPost = UILabel()
    var dateCreated = UILabel()
    var viewBordar = UIView()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(viewBordar)
        viewBordar.addSubview(usernamePoster)
        viewBordar.addSubview(contentPost)
        viewBordar.addSubview(linkPost)
        viewBordar.addSubview(dateCreated)
        
        
        viewBordar.layer.borderColor = UIColor(#colorLiteral(red: 0.666983366, green: 0.8120718598, blue: 0.8098518252, alpha: 1)).cgColor
        viewBordar.layer.borderWidth = 2.0
        viewBordar.layer.cornerRadius = 15.0
        
        
        contentPost.numberOfLines = 0

//      let cellFont = UIFont(name: _.font.fontName, size: 13)
//      dateCreated.font = cellFont
//      usernamePoster.font = cellFont
//      contentPost.font = cellFont
//      linkPost.font = cellFont
       
      setLablesConstraint()
       
    }
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
     
    func setLablesConstraint(){
  //RequstTypeConstraint
        viewBordar.translatesAutoresizingMaskIntoConstraints = false
        viewBordar.widthAnchor.constraint(equalToConstant: 340).isActive = true
        viewBordar.heightAnchor.constraint(equalToConstant: 180).isActive = true
        viewBordar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewBordar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
        
      dateCreated.translatesAutoresizingMaskIntoConstraints = false
        dateCreated.topAnchor.constraint(equalTo: viewBordar.topAnchor ,constant: 10).isActive = true
//    dateCreated.heightAnchor.constraint(equalToConstant: 30)
        dateCreated.trailingAnchor.constraint(equalTo: viewBordar.trailingAnchor , constant: -20 ).isActive = true

      contentPost.translatesAutoresizingMaskIntoConstraints = false
        contentPost.centerYAnchor.constraint(equalTo: viewBordar.centerYAnchor).isActive = true
      contentPost.heightAnchor.constraint(equalToConstant: 90).isActive = true
        contentPost.widthAnchor.constraint(equalToConstant: 300).isActive = true
        contentPost.centerXAnchor.constraint(equalTo: viewBordar.centerXAnchor).isActive = true

      linkPost.translatesAutoresizingMaskIntoConstraints = false
      linkPost.topAnchor.constraint(equalTo: contentPost.bottomAnchor , constant: 10).isActive = true
        linkPost.heightAnchor.constraint(equalToConstant: 30).isActive = true
        linkPost.leftAnchor.constraint(equalTo: viewBordar.leftAnchor, constant: 20).isActive = true
        linkPost.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

}
