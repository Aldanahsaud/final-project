//
//  BookmarkViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 19/01/2022.
//

import UIKit
import Firebase

class BookmarkViewController: UIViewController {
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()

    var bookArray : [User] = []
    
    let myBookmarkTable : UITableView = {

        $0.rowHeight = 110
        $0.backgroundColor = UIColor(named: "Color")
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0

    }(UITableView())
    let label : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(named: "Color-1")
        $0.numberOfLines = 0
        
        return $0
    }(UILabel())

    
    let label2 : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(named: "Color-1")
        $0.numberOfLines = 0
        
        return $0
    }(UILabel())
    
    let line : UIImageView = {
        $0.image = UIImage(named: "line2")
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(label2)
        view.addSubview(line)
        view.backgroundColor = UIColor(named: "Color")

        NSLayoutConstraint.activate([

            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            label.heightAnchor.constraint(equalToConstant: 200),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
            label.widthAnchor.constraint(equalToConstant: 400),
            
            line.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            line.widthAnchor.constraint(equalToConstant: 390),
            line.heightAnchor.constraint(equalToConstant: 50),
            line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            
            label2.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            label2.heightAnchor.constraint(equalToConstant: 200),
            label2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
            label2.widthAnchor.constraint(equalToConstant: 400),
        ])
        loadArray()
    }
    
    func loadArray(){
        db.collection("Users")
                       .getDocuments() { (querySnapshot, err) in
                           if let err = err {
                               print("Error getting documents: \(err)")
                           } else {
                               for document in querySnapshot!.documents {
                                   let data = document.data()
                                   let x = data["bookmark"] as! [String]
                                   self.label.text = x[0]
//                                   self.label2.text = x[1]
                                   
                                   
                               }
                           }
                       }
       }



}
