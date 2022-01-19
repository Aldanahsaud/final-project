//
//  GroupViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class GroupViewController: UIViewController {

    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser?.uid
    
    let labelYoga : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = "hiiia"
        
        
       return $0
    }(UILabel())
    
    let buttonYoga : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.setTitle("Join", for: .normal)
        $0.addTarget(self, action: #selector(makeSure), for: .touchUpInside)
        
        return $0
    }(UIButton())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelYoga)
        view.addSubview(buttonYoga)
        
        NSLayoutConstraint.activate([
            labelYoga.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelYoga.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            
            buttonYoga.leftAnchor.constraint(equalTo: labelYoga.rightAnchor, constant: 160),
            buttonYoga.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
        ])
        getGroups()
    }
    func getGroups() {
//        if let userID = userID {
            db.collection("Groups")
                .getDocuments {
                        qurySnapShot, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            for doc in qurySnapShot!.documents {
                                let data = doc.data()
                                if (data["name"] as? String ?? "not found") == "Yoga" {
                                    self.labelYoga.text = data["name"] as? String ?? "not found"
                                }
                                
                            }
                        }
                }
//    }
}
    @objc func makeSure() {
        let nextVC = JoiningViewController()
        present(nextVC, animated: true, completion: nil)
    }
}
