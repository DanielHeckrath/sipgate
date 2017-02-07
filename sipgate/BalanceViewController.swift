//
//  BalanceViewController.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
    
    @IBOutlet var labelBalance: UILabel!
    
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
        labelBalance.text = "\(fraction) \(currency)"
    }
    
}
