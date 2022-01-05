//
//  ProfileViewController.swift
//  sheet2
//
//  Created by AlDanah Aldohayan on 03/01/2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    // Not Logged in View
    let currentUser = Auth.auth().currentUser
    
    let labelProfile: UILabel = {
        $0.text = "الصفحة الشخصية"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black

        return $0
    }(UILabel())

    let loginButton: UIButton = {
        $0.backgroundColor = #colorLiteral(red: 0.9243349433, green: 0.8509200811, blue: 0.727404654, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("تسجيل دخول", for: .normal)
        $0.addTarget(self, action: #selector(profilrGoLogin), for: .touchUpInside)
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitleColor(.black, for: .normal)

        return $0
    }(UIButton())

    let SignUpButton: UIButton = {
        $0.backgroundColor = #colorLiteral(red: 0.9243349433, green: 0.8509200811, blue: 0.727404654, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("إنشاء حساب", for: .normal)
        $0.addTarget(self, action: #selector(profilrGoSignUp), for: .touchUpInside)
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.black.cgColor
        $0.setTitleColor(.black, for: .normal)

        return $0
    }(UIButton())

    
    
    // ++Logged in View vars and lets
    let db = Firestore.firestore()
    var userId = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    var updateImageName = "\(UUID().uuidString).png"
    
    
    var postArray : [Posts] = []
    
    //UIImageView
    let userIcon : UIImageView = {
      let imageView = UIImageView()
      imageView.tintColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
      imageView.contentMode = .scaleAspectFill
      imageView.frame.size = CGSize(width: 70, height: 70)
      imageView.layer.cornerRadius = imageView.frame.width/2
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
     
    //UIButton-signOutBtn
      let signOutBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.setTitleColor(.white, for: .normal)
          button.tintColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(signOut), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // UILabel-nameLable
    let nameLbl : UILabel = {
      let nameLable = UILabel()
      nameLable.textAlignment = .center
      nameLable.font = UIFont.systemFont(ofSize: 20, weight: .regular)
      nameLable.adjustsFontSizeToFitWidth = true
      nameLable.translatesAutoresizingMaskIntoConstraints = false
      return nameLable
    }()
    //UILabel-numberOfGherasLbl
    let pointLbl : UILabel = {
      let numberOfGherasLbl = UILabel()
      numberOfGherasLbl.textAlignment = .center
      numberOfGherasLbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
      numberOfGherasLbl.adjustsFontSizeToFitWidth = true
      numberOfGherasLbl.translatesAutoresizingMaskIntoConstraints = false
      return numberOfGherasLbl
    }()
     
    //UIButton-editPhotoBtn
    let editPhotoBtn : UIButton = {
      let editPhotoBtn = UIButton()
      editPhotoBtn.setTitle("تعديل الصورة", for: .normal)
      editPhotoBtn.setTitleColor(#colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1), for: .normal)
      editPhotoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
      editPhotoBtn.addTarget(self, action: #selector(editPhotoPressed), for: .touchDown)
      editPhotoBtn.translatesAutoresizingMaskIntoConstraints = false
      return editPhotoBtn
    }()
    //UIImageView-GherasImage
    let GherasImage : UIImageView = {
      let imageView = UIImageView()
      imageView.image = UIImage(systemName: "rosette")
      imageView.tintColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
      imageView.contentMode = .scaleAspectFit
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
     
    //Tableview
    let tableView : UITableView = {
      let tableView = UITableView()
      tableView.rowHeight = 110
      tableView.backgroundColor = .white
      tableView.translatesAutoresizingMaskIntoConstraints = false
      return tableView
    }()
    //UIButton-signOutBtn
      let infoBtn : UIButton = {
        let infoBtn = UIButton()
        infoBtn.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoBtn.tintColor = .white
          infoBtn.backgroundColor = #colorLiteral(red: 0.04236891121, green: 0.6102550626, blue: 0.2603748143, alpha: 1)
        infoBtn.frame.size = CGSize(width: 40, height: 40)
        infoBtn.layer.cornerRadius = infoBtn.frame.width/2
        infoBtn.addTarget(self, action: #selector(questionsView), for: .touchDown)
        infoBtn.translatesAutoresizingMaskIntoConstraints = false
        return infoBtn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        if self.currentUser == nil {
            view.addSubview(loginButton)
            view.addSubview(SignUpButton)


            NSLayoutConstraint.activate([
                loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loginButton.widthAnchor.constraint(equalToConstant: 120),
                loginButton.heightAnchor.constraint(equalToConstant: 50),

                SignUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
                SignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                SignUpButton.widthAnchor.constraint(equalToConstant: 120),
                SignUpButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        } else {
            setupView()
            imagePicker.delegate = self
            view.backgroundColor = .white
            //+++
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "reqCell")
//            loudData()
        }
        
    }

    // Not Logged in Functions
    @objc func profilrGoLogin() {
        let goVC = LoginViewController()
        goVC.modalPresentationStyle = .fullScreen
        present(goVC, animated: true, completion: nil)
    }
    @objc func profilrGoSignUp() {
        let goVC = SignUpViewController()
        goVC.modalPresentationStyle = .fullScreen
        present(goVC, animated: true, completion: nil)
    }
    
    // Logged in Functions
    
    override func viewWillAppear(_ animated: Bool) {
      DispatchQueue.main.async {
        self.loadUser()
      }
    }
        
        @objc func questionsView() {
          let vc = HomeViewController()
          vc.modalPresentationStyle = .fullScreen
          self.present(vc, animated: true, completion: nil)
        }
         
        @objc func editPhotoPressed() {
          imagePicker.sourceType = .photoLibrary
          present(imagePicker, animated: true, completion: nil)
        }
         
        @objc func signOut() {
          let alert = UIAlertController(title: "", message: "هل انت متأكد من تسجيل الخروج؟", preferredStyle: .alert)
          let signOutBtn = UIAlertAction(title: "تسجيل خروج", style: .destructive) { alertAction in
            do {
              try Auth.auth().signOut()
              let vc = SignUpViewController()
              vc.modalPresentationStyle = .fullScreen
              self.present(vc, animated: true, completion: nil)
            }catch {
              print("Error: ",error.localizedDescription)
            }
          }
          alert.addAction(signOutBtn)
          alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))
          present(alert, animated: true, completion: nil)
        }
        
        //MARK: fetch user data
        func loadUser() {
          if let userId = userId {
            db.collection("Users").document(userId).getDocument { documentSnapshot, error in
              if let error = error {
                print("Error: ",error.localizedDescription)
              }else {
                self.nameLbl.text = documentSnapshot?.get("name") as? String ?? "nil"
                self.pointLbl.text = String(documentSnapshot?.get("point") as? Int ?? 0) + "_"
                let imgStr = documentSnapshot?.get("userIcon") as? String
                if imgStr == "nil" {
                  self.userIcon.image = UIImage(systemName: "person.circle")
                }
                else {
      //            sleep(2)
                    self.loadImage(imgStr: imgStr!)
                   
                }
                 
                 
              }
            }
          }
        }
    func loadImage(imgStr: String) {
      let url = "gs://gheras-196bd.appspot.com/images/" + "\(imgStr)"
   
      let Ref = Storage.storage().reference(forURL: url)
      Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
        if error != nil {
          print("Error: Image could not download!")
          print(error?.localizedDescription)
        } else {
          self.userIcon.image = UIImage(data: data!)
        }
      }
    }
        
        //MARK: update user icon
        func updateUserIcon() {
          uploadImage()
          self.db.collection("Users")
            .document(userId!).updateData(
              [
                "userIcon": userIcon.image == UIImage(systemName: "person.circle") ? "nil" : updateImageName
              ])
          {(error) in
            if error == nil {
              print("Added image Succ..")
            }else {
              print(error!.localizedDescription)
            }
          }
           
        }
         
        func uploadImage(){
          let imagefolder = Storage.storage().reference().child("images")
          if let imageData = userIcon.image?.jpegData(compressionQuality: 0.1) {
            imagefolder.child(updateImageName).putData(imageData, metadata: nil){
              (metaData , error) in
              if let error = error {
                print(error.localizedDescription)
              }else {
                print("update image Succ..")
              }
            }
          }
        }
//        func loudData(){
//            self.db.collection("Posts").getDocuments { [self] (qurySnapshot, error) in
//                   if let error = error {
//                       print(error)
//                   }else{
//                       for doc in qurySnapshot!.documents {
//                           let data = doc.data()
//                           let timestamp: Timestamp = data["RequstDate"] as! Timestamp
//                           let datetest: Date = timestamp.dateValue()
//                           if (doc.get("UsarID")as? String ?? "nil") == Auth.auth().currentUser?.uid {
//                               self.postArray.append(Posts(content: <#T##String#>, username: <#T##String#>, link: <#T##String#>, date: <#T##Date#>))}
//                           self.tableView.reloadData()
//                       }
//                   }
//               }
//           }
}

//MARK: -UIImagePickerController
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    userIcon.image = pickedImage
    updateUserIcon()
    picker.dismiss(animated: true, completion: nil)
  }
}



//MARK: -NSLayoutConstraint
extension ProfileViewController {
  private func setupView() {
    view.addSubview(userIcon)
    view.addSubview(signOutBtn)
    view.addSubview(nameLbl)
    view.addSubview(GherasImage)
    view.addSubview(pointLbl)
    view.addSubview(editPhotoBtn)
    view.addSubview(tableView)
    tableView.setEmptyMessage("لا يوجد طلبات، اتجه للخريطة \n وحدد موقع الغرس لتنفيذ طلب جديد!")
    view.addSubview(infoBtn)
     
    NSLayoutConstraint.activate([
      signOutBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
      signOutBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      signOutBtn.heightAnchor.constraint(equalToConstant: 40),
      signOutBtn.widthAnchor.constraint(equalToConstant: 40),
       
      userIcon.topAnchor.constraint(equalTo: signOutBtn.bottomAnchor, constant: 20),
      userIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      userIcon.heightAnchor.constraint(equalToConstant: 70),
      userIcon.widthAnchor.constraint(equalToConstant: 70),
       
      nameLbl.topAnchor.constraint(equalTo: userIcon.topAnchor,constant: 0),
      nameLbl.trailingAnchor.constraint(equalTo: userIcon.leadingAnchor, constant: -10),
      nameLbl.heightAnchor.constraint(equalToConstant: 35),
       
      GherasImage.topAnchor.constraint(equalTo: nameLbl.bottomAnchor,constant: 8),
      GherasImage.trailingAnchor.constraint(equalTo: nameLbl.trailingAnchor),
      GherasImage.heightAnchor.constraint(equalToConstant: 25),
      GherasImage.widthAnchor.constraint(equalToConstant: 25),
       
       
      pointLbl.trailingAnchor.constraint(equalTo: GherasImage.leadingAnchor,constant: -5),
      pointLbl.heightAnchor.constraint(equalToConstant: 25),
      pointLbl.centerYAnchor.constraint(equalTo: GherasImage.centerYAnchor),
       
      editPhotoBtn.topAnchor.constraint(equalTo: userIcon.bottomAnchor,constant: 5),
      editPhotoBtn.heightAnchor.constraint(equalToConstant: 25),
      editPhotoBtn.centerXAnchor.constraint(equalTo: userIcon.centerXAnchor),
       
       
      //++++
      tableView.topAnchor.constraint(equalTo: pointLbl.bottomAnchor, constant: 100 ),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20 ),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20 ),
      tableView.heightAnchor.constraint(equalToConstant: 350),
       
      infoBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
      infoBtn.leadingAnchor.constraint(equalTo: tableView.leadingAnchor , constant: 0),
      infoBtn.heightAnchor.constraint(equalToConstant: 40),
      infoBtn.widthAnchor.constraint(equalToConstant: 40),
       
    ])
  }
}


extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postArray.count
  }
   
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reqCell", for: indexPath) as! PostTableViewCell
    // dateformatter
    let date = postArray[indexPath.row].date
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    stringDate = formatter.string(from: date ?? Date())
    //
     
    cell.dateCreated.text = stringDate
      cell.usernamePoster.text = postArray[indexPath.row].username
      cell.contentPost.text = postArray[indexPath.row].content
      cell.linkPost.text = postArray[indexPath.row].link
    return cell
  }
   
}







extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
