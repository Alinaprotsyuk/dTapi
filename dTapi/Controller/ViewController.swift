//
//  ViewController.swift
//  dTapi
//
//  Created by ITA student on 10/11/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    private var httpStatusCode : Int? = nil
    
    let queryService = QueryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    private func showMessage(message: String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        let username = loginField.text
        let password = passwordField.text
        
        if let user = username, let psw = password {
            doLogin(user, psw)
        } else {
            return showMessage(message: "Write down all fields")
        }
    }
    
    func doLogin(_ user:String, _ psw:String)
    {
        
        queryService.postRequests(parameters : ["username" : user, "password" : psw], sufix : "login/index", completion: {(results:Int?) in
            
            if let code = results {
                self.httpStatusCode = code
                DispatchQueue.main.async {
                    print(self.httpStatusCode!)
                    if self.httpStatusCode == 200 {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "Another") as? TableViewController
                        self.navigationController?.pushViewController(vc!,animated: true)
                    } else {
                        self.showMessage(message: "Invalid login or password")
                    }
                }
            }
        })
       
    }
}


