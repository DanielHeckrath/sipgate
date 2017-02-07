//
//  ViewController.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {

    @IBOutlet var fieldUserName: UITextField!
    @IBOutlet var fieldPassword: UITextField!
    
    @IBOutlet var buttonGetCredentials: UIButton!
    
    var token: String?
    
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
            DispatchQueue.main.async {
                guard let tokenResponse = response else {
                    self.buttonGetCredentials.isEnabled = false
                    return
                }
            
                print(tokenResponse)
            
                guard let token = tokenResponse.token else {
                    self.buttonGetCredentials.isEnabled = false
                    return
                }
            
                self.buttonGetCredentials.isEnabled = true
                self.token = token
            }
        }
    }
    
    @IBAction
    func onGetBalancePressed(sender: AnyObject) {
        guard token != nil else {
            return
        }
        
        RestManager.shared.getBalance(token: token!) { response in
            guard let amount = response?.amount else {
                return
            }
            
            guard let currency = response?.currency else {
                return
            }
            
            DispatchQueue.main.sync {
                self.updateBalanceLabel(amount: amount, currency: currency)
            }
        }
    }
    
    func updateBalanceLabel(amount: Int, currency: String) {
        let fraction = Float(amount) / 10000.0
        let alert = UIAlertController(title: "Current Balance", message: "\(fraction) \(currency)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

