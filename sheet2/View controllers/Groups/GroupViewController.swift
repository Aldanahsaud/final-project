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
        
        
       return $0
    }(UILabel())
    
    let buttonYoga : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(#colorLiteral(red: 0.5137255192, green: 0.5137255192, blue: 0.5137255192, alpha: 1))
        $0.setTitle("شارك", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.addTarget(self, action: #selector(makeSure), for: .touchUpInside)
        
        return $0
    }(UIButton())
    
    let labelTitle : UILabel = {
        $0.font = UIFont(name: "Arial", size: 35)
        $0.text = "◎ مجموعات الصحبه ◎"
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    let labelBranch : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = "◎ مجموعات الصحبه ◎"
        
       return $0
    }(UILabel())
    
    let buttonBranch: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(#colorLiteral(red: 0.5137255192, green: 0.5137255192, blue: 0.5137255192, alpha: 1))
        $0.setTitle("شارك", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.addTarget(self, action: #selector(makeSure), for: .touchUpInside)
        
        return $0
    }(UIButton())
    
    let button4: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(#colorLiteral(red: 0.5137255192, green: 0.5137255192, blue: 0.5137255192, alpha: 1))
        $0.setTitle("شارك", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.addTarget(self, action: #selector(makeSure), for: .touchUpInside)
        
        return $0
    }(UIButton())
    
    
    let button5: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(#colorLiteral(red: 0.5137255192, green: 0.5137255192, blue: 0.5137255192, alpha: 1))
        $0.setTitle("شارك", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.0
        $0.layer.borderWidth = 2.0
        $0.addTarget(self, action: #selector(makeSure), for: .touchUpInside)
        
        return $0
    }(UIButton())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelYoga)
        view.addSubview(buttonYoga)
        view.addSubview(labelTitle)
        
        view.backgroundColor = UIColor(named: "Color")
        
        NSLayoutConstraint.activate([
            
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelYoga.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelYoga.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            
            buttonYoga.leftAnchor.constraint(equalTo: labelYoga.rightAnchor, constant: 160),
            buttonYoga.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            buttonYoga.widthAnchor.constraint(equalToConstant: 100),
            
            
        ])
        getGroups()
    }
    func getGroups() {
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
}
    
    
    @objc func makeSure() {
        let nextVC = JoiningViewController()
        present(nextVC, animated: true, completion: nil)
    }
}
