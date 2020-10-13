//
//  LoginViewController.swift
//  Twitter
//
//  Created by Yanni Speron on 10/12/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var shouldStayLoggedInSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shouldStayLoggedInSwitch.setOn(UserDefaults.standard.bool(forKey: "wantsStayLoggedInOn"), animated: false)

        loginButton.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "userLoggedIn")) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    @IBAction func shouldStayLoggedInSwitchToggled(_ sender: Any) {
        UserDefaults.standard.set(shouldStayLoggedInSwitch.isOn, forKey: "wantsStayLoggedInOn")
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: myUrl, success: {
            if (self.shouldStayLoggedInSwitch.isOn) {
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
            }
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (err: Error) in
            print("Could not login, \"\(err.localizedDescription)\"")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
