//
//  OfferViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class OfferViewController: UIViewController {
    
    let db = Firestore.firestore()
    var userId = Auth.auth().currentUser?.uid
    
    var offerArray: [Offer] = []
    
    
    let label : UILabel = {
        $0.font = UIFont(name: "Arial", size: 50)
        $0.text = "✩عروضنا✩"
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UILabel())
    
    let myTableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 110
        tableView.backgroundColor = UIColor(named: "Color")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableView)
        view.addSubview(label)
        view.backgroundColor = UIColor(named: "Color")
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
//            label.widthAnchor.constraint(equalToConstant: 300),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            myTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            myTableView.widthAnchor.constraint(equalToConstant: 400),
            myTableView.heightAnchor.constraint(equalToConstant: 650),
            
        ])
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(OfferTableViewCell.self, forCellReuseIdentifier: "offerCell")
        
        
        showOffer()
    }
    func showOffer(){
        db.collection("Offers").order(by: "endOffer", descending: false).getDocuments { qurySnapShot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                        for doc in qurySnapShot!.documents {
                            let data = doc.data()
                                self.offerArray.append(Offer(name: data["name"] as? String ?? "", content:  data["content"] as? String ?? "", endOffer:  data["endOffer"] as? String ?? ""))}
                                self.myTableView.reloadData()

                            }
                        }
                    }
            }

    
    
    extension OfferViewController : UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return offerArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferTableViewCell
            
            
            cell.nameLabel.text = offerArray[indexPath.row].name
            cell.contentText.text = offerArray[indexPath.row].content
            cell.endOfferLabel.text = offerArray[indexPath.row].endOffer
            
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 300
        }
    
    }
