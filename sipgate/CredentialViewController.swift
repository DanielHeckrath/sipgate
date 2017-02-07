//
//  ViewController.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import UIKit

class CredentialViewController: UIViewController {

    @IBOutlet var fieldUserName: UITextField!
    @IBOutlet var fieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction
    func onSendPressed(sender: AnyObject) {
        guard let username = fieldUserName.text else {
            return
        }
        
        guard let password = fieldPassword.text else {
            return
        }
        
        if username.isEmpty || password.isEmpty {
            return
        }
        
        RestManager.shared.authenticate(username: username, password: password) { response in
            guard let tokenResponse = response else {
                return
            }
            
            print(tokenResponse)
            
            guard let token = tokenResponse.token else {
                return
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ShowBalanceSegue", sender: token)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBalanceSegue" {
            guard let balanceController = segue.destination as? BalanceViewController else {
                return
            }
            
            guard let token = sender as? String else {
                return
            }
            
            balanceController.token = token
        }
    }

}

