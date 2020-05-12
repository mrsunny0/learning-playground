//
//  ViewController.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/2/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    // elements
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var loginSwitch: UISwitch!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var loginBool = true
    
    // user defaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve user defaults
        if let email = defaults.string(forKey: "email"), let password = defaults.string(forKey: "password") {
            inputEmail.text = email
            inputPassword.text = password
        }
        
        // callback for removing keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = inputEmail.text, let password = inputPassword.text {
            let onOff = loginSwitch.isOn

            // login
            if onOff {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if let e = error {
                        print(e)
                    } else {
                        self.setUserDefaults(email, password)
                        self.performSegue(withIdentifier: "goToSearch", sender: self)
                    }
                }
            }
            // signup
            else {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let e = error {
                        print(e)
                    } else {
                        self.setUserDefaults(email, password)
                        self.performSegue(withIdentifier: "goToSearch", sender: self)
                    }
                }
            }
        }
    }
    
    @IBAction func submitPressed(_ sender: UISwitch) {
        loginBool = !loginBool
        
        // change labels
        typeLabel.text = loginBool ? "Login" : "Signup"
        submitButton.titleLabel?.text = loginBool ? "Login" : "Signup"
        
        // toggle switch
        sender.setOn(loginBool, animated: true)
    }
    
    func setUserDefaults(_ email: String, _ password: String) {
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
    }
    
}

