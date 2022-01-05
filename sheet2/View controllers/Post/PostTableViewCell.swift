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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(usernamePoster)
      addSubview(contentPost)
      addSubview(linkPost)
      addSubview(dateCreated)
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
      dateCreated.translatesAutoresizingMaskIntoConstraints = false
    dateCreated.topAnchor.constraint(equalTo: topAnchor ,constant: 10).isActive = true
    dateCreated.heightAnchor.constraint(equalToConstant: 30)
    dateCreated.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
       
  //RequstIDConstraint
      usernamePoster.translatesAutoresizingMaskIntoConstraints = false
      usernamePoster.topAnchor.constraint(equalTo: dateCreated.bottomAnchor , constant: 10).isActive = true
      usernamePoster.heightAnchor.constraint(equalToConstant: 30)
      usernamePoster.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true// constant will change
       
      contentPost.translatesAutoresizingMaskIntoConstraints = false
      contentPost.topAnchor.constraint(equalTo: usernamePoster.bottomAnchor , constant: 10).isActive = true
      contentPost.heightAnchor.constraint(equalToConstant: 30)
      contentPost.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
       
      linkPost.translatesAutoresizingMaskIntoConstraints = false
      linkPost.topAnchor.constraint(equalTo: contentPost.bottomAnchor , constant: 10).isActive = true
      linkPost.heightAnchor.constraint(equalToConstant: 30)
      linkPost.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
    }

}
