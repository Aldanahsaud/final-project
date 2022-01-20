//
//  UserProfileViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 18/01/2022.
//

import UIKit
import Firebase

class moreContentViewController: UIViewController {
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    
    var contentLong = ""
    var linkk = ""
    var namee = ""
    
    
    
    let labelContent : UILabel = {
        $0.numberOfLines = 0
        $0.textColor = UIColor(named: "Color-1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    let labelUsername : UILabel = {
        $0.numberOfLines = 0
        $0.textColor = UIColor(named: "Color-1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    var bookmark : UIButton = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "bookmark"), for: .normal)
        $0.addTarget(self, action: #selector(bookmarkFunction), for: .touchUpInside)
        
        
        return $0
    }(UIButton())
    
    var linkHome : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(goUrl), for: .touchUpInside)
//        $0.tintColor = .blue
//        $0.backgroundColor = .red
        
        return $0
    }(UIButton())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color")
        print("+++++++++++++++")
        print(contentLong)
        labelContent.text = contentLong
        if linkk.contains("pinterest") {
            linkHome.setImage(UIImage(named: "pinterest"), for: .normal)
        } else if linkk.contains("youtube") {
            linkHome.setImage(UIImage(named: "youtube"), for: .normal)
        } else if linkk.contains("amazon") {
            linkHome.setImage(UIImage(named: "amazon"), for: .normal)
        } else {
            linkHome.setImage(UIImage(named: "link"), for: .normal)
        }
        view.addSubview(labelContent)
        view.addSubview(bookmark)
        view.addSubview(linkHome)
        view.addSubview(labelUsername)
        
        NSLayoutConstraint.activate([
            
            labelUsername.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            labelUsername.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            labelUsername.widthAnchor.constraint(equalToConstant: 70),
            labelUsername.heightAnchor.constraint(equalToConstant: 50),
            
            labelContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            labelContent.widthAnchor.constraint(equalToConstant: 380),
            labelContent.heightAnchor.constraint(equalToConstant: 400),
            labelContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            labelContent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            
            bookmark.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            bookmark.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 5),
            bookmark.widthAnchor.constraint(equalToConstant: 35),
            bookmark.heightAnchor.constraint(equalToConstant: 70),
            
            linkHome.leftAnchor.constraint(equalTo: bookmark.rightAnchor, constant: 100),
            linkHome.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 5),
            linkHome.widthAnchor.constraint(equalToConstant: 100),
            linkHome.heightAnchor.constraint(equalToConstant: 50),
        ])
        print(Auth.auth().currentUser?.uid)

    }
    @objc func bookmarkFunction(){
        let userId = Auth.auth().currentUser?.uid
        if let userId = userId {
            self.db.collection("Users").document(userId).updateData([
                "bookmark" : FieldValue.arrayUnion([contentLong])
            ])
        }
        print("helll")
        
    }
    @objc func goUrl(){
        if let url = NSURL(string: linkk){
            UIApplication.shared.openURL(url as URL)
           }
    }
   
}











