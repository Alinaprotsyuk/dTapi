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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let preferences = UserDefaults.standard
        
        if(preferences.object(forKey: "session") != nil)
        {
            LoginDone()
        }
        else
        {
            LoginToDo()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

    
    @IBAction func logIn(_ sender: UIButton) {
        let username = loginField.text
        let password = passwordField.text
        
        if(username == "" || password == "")
        {
            return
        }
        
        DoLogin(username!, password!)
    }
    
    func DoLogin(_ user:String, _ psw:String)
    {
        var parameters = [String:String]()
        parameters["username"] = user
        parameters["password"] = psw
        
        guard let url = URL(string: "http://vps9615.hyperhost.name/login/index") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                

            } else {
                DispatchQueue.main.async {
                     self.LoginDone()
                }
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            //self.label.text = "Ok"
            }.resume()
        
    }
    
    func LoginDone()
    {
        label.text = "Ok"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Second") as? SecondViewController
        //vc.newsObj = newsObj
        self.navigationController?.pushViewController(vc!,animated: true)
    }
    
    func LoginToDo()
    {
        label.text = "dTapi"
    }
}


