//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    // set up db
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // hide elements
        navigationItem.hidesBackButton = true
        
        // add title property
        self.title = "This is a title"
        
        // set up source
        tableView.delegate = self
        tableView.dataSource = self
        
        // register .xib
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        // create data from db
        
        loadMessages()
    }
    
    func loadMessages() {
        // db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
        db.collection(K.FStore.collectionName)
            // order
            .order(by: K.FStore.dateField)
            // retreive the documents
            .addSnapshotListener { (querySnapshot, error) in
            // empty array
            self.messages = []
            
            // update messages
            if let e = error {
                print(e)
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    for snapShot in snapShotDocuments {
                        let data = snapShot.data()
                        if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                            // add to message array
                            self.messages.append(Message(sender: sender, body: body))
                            
                            // reload data on the main queue
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // store text in body
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    print("success")
                }
            }
        }
    }
    
    // sign out
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        // get the current user
        let firebaseAuth = Auth.auth()
        
        // attempt to sign out
        do {
            try firebaseAuth.signOut()
            
            // go back to root
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
}


//MARK: - UI Table Data Source
extension ChatViewController: UITableViewDataSource {
    
    // return number of rows (or numbers in array)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    // column
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create cell based on identifier
        // let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        // create the custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        // get the message
        let message = messages[indexPath.row]
        
        // check if sender is the same as current sign in
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView?.isHidden = true
            cell.rightImageView?.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        else {
            cell.leftImageView?.isHidden = false
            cell.rightImageView?.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.blue)
            cell.label.textColor = UIColor(named: K.BrandColors.lightBlue)
        }
        
        // add data to cell
        // cell.textLabel?.text = messages[indexPath.row].body
        cell.label?.text = message.body
        
        return cell
    }
}

//MARK: - UITable Delegate
// this add interactivity
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
