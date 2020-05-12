//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

//    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.title
//         titleLabel.text = "⚡️FlashChat"
//        var charIndex = 0
//        let titleText = "⚡️FlashChat"
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
//            if charIndex < titleText.count - 1 {
//                self.titleLabel.text?.append("100")
//                charIndex += 1
//            } else {
//                timer.invalidate()
//            }
//        }
    
    }
    
    // remove navbar when appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // bring it back up when disappear, and moving to another view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
