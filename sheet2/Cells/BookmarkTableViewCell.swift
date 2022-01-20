//
//  BookmarkTableViewCell.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 20/01/2022.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {

    
    var contentBook : UILabel = {
        $0.numberOfLines = 0
        $0.textColor = UIColor(named: "Color-1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(contentBook)
       
        setLablesConstraint()
    }
    
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    

    func setLablesConstraint(){
        contentBook.topAnchor.constraint(equalTo: topAnchor , constant: 10).isActive = true
        contentBook.heightAnchor.constraint(equalToConstant: 30).isActive = true
        contentBook.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -20 ).isActive = true
    }

}
