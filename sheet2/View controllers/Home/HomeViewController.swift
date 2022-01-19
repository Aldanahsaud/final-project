//
//  ViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let db = Firestore.firestore()
    var homeArray : [Home] = []
    let refreshControl = UIRefreshControl()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 110
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loudData()
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 590)
        ])
        
        tableView.reloadData()
//        print(homeArray)
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl.addTarget(self, action: #selector(refreshTableView),for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    func loudData(){
        db.collection("Posts").order(by: "date", descending: true)
            .getDocuments { [self]  (qurSnapShot, error) in
                homeArray = []
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for doc in qurSnapShot!.documents {
                        let data = doc.data()
                        self.homeArray.append(Home(username: data["usernamep"] as? String ?? "nil", content: data["content"] as? String ?? "nil", link: data["link"] as? String ?? "nil"))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            }
    }
    @objc func refreshTableView(_ sender: AnyObject) {
//        homeArray.removeAll()
        loudData()
        refreshControl.endRefreshing()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.userNameHome.setTitle(homeArray[indexPath.row].username, for: .normal)
        cell.contentHome.text = homeArray[indexPath.row].content
        cell.linkHome.setTitle(homeArray[indexPath.row].link, for: .normal)
        cell.userNameHome.addTarget(self, action: #selector(goProfile), for: .touchUpInside)
        cell.bookmark.tag = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    @objc func goProfile(_ sender: UIButton){
        let array = homeArray[sender.tag]
        let vc = UserProfileViewController()
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
}
