//
//  FirstViewController.swift
//  FirebaseSample
//
//  Created by 矢野将輝 on 2017/09/30.
//  Copyright © 2017年 garireo. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {

    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var ref: DatabaseReference!

    @IBAction func send(_ sender: Any) {
        let name = nameTextField.text!
        let message = messageTextField.text!
        
        let messageData = ["name": name, "message": message]
        self.ref.childByAutoId().setValue(messageData)
        
        nameTextField.text = ""
        messageTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.ref.observe(.childAdded, with: { (snapshot) -> Void in
            let postDict = snapshot.value as! [String : AnyObject]
            if let name = postDict["name"] as? String,
                let message = postDict["message"] as? String {

                let displayMessage = self.chatTextView.text!
                if displayMessage.isEmpty {
                    self.chatTextView.text.append("\(name) : \(message)")
                } else {
                    self.chatTextView.text.append("\n\(name) : \(message)")
                }
            }
        })
    }
}

