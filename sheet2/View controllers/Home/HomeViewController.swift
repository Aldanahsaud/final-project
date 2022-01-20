//
//  ViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    let db = Firestore.firestore()
    var homeArray : [Home] = []
    var filtred : [Home] = []
    let refreshControl = UIRefreshControl()
    
    
    let searchbar : UISearchBar = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .blue
        
        return $0
    }(UISearchBar())
    
    let myHometableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 110
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let labelTitle : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "©حقوق الدانه الضحيان"
        $0.textColor = UIColor(named: "Color-3")
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loudData()
        view.backgroundColor = UIColor(named: "Color")
        view.addSubview(myHometableView)
        view.addSubview(searchbar)
        view.addSubview(labelTitle)
        searchbar.delegate = self
        
        
        myHometableView.delegate = self
        myHometableView.dataSource = self
        myHometableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        
        NSLayoutConstraint.activate([
            
            
            
            myHometableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            myHometableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            myHometableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            myHometableView.heightAnchor.constraint(equalToConstant: 590),
            
            searchbar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            searchbar.widthAnchor.constraint(equalToConstant: 300),
            searchbar.heightAnchor.constraint(equalToConstant: 70),
            searchbar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: myHometableView.bottomAnchor, constant: 10),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        myHometableView.reloadData()
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl.addTarget(self, action: #selector(refreshTableView),for: .valueChanged)
        myHometableView.addSubview(refreshControl)
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
                        self.filtred = self.homeArray
                    }
                    DispatchQueue.main.async {
                        self.myHometableView.reloadData()
                    }
                    
                }
            }
    }
    @objc func refreshTableView(_ sender: AnyObject) {
        loudData()
        refreshControl.endRefreshing()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                filtred = []
                if searchText == ""{

                   filtred = homeArray
                }
                else{
                for arr in homeArray{
                    if arr.content.lowercased().contains(searchText.lowercased()){
                        filtred.append(arr)
                    }
                }
                    myHometableView.reloadData()
            }
               
            
    }
    override var prefersStatusBarHidden: Bool {
           return true
       }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtred.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.userNameHome.text = filtred[indexPath.row].username
        cell.contentHome.text = filtred[indexPath.row].content
        cell.linkHome.text = filtred[indexPath.row].link
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = moreContentViewController()
        let cell = myHometableView.cellForRow(at: indexPath) as! HomeTableViewCell
        
        let conxx = cell.contentHome.text!
        var goArray = filtred[indexPath.row]
        goArray.content = conxx
        nextVC.contentLong = goArray.content
        
        let linxx = cell.linkHome.text!
        goArray.link = linxx
        nextVC.linkk = goArray.link
        
        let namxx = cell.userNameHome.text!
        goArray.username = namxx
        nextVC.namee = goArray.username
        
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    
    
}




