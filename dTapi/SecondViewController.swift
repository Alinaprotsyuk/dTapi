//
//  SecondViewController.swift
//  dTapi
//
//  Created by ITA student on 10/11/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit



class SecondViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   
    var records = [Records]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //onGetTapped()
        Records.getRecords(completion: { (results:[Records]?) in
            
            if let weatherData = results {
                self.records = weatherData
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        })
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = records[indexPath.row].name
        cell.detailTextLabel?.text = records[indexPath.row].description
        return cell
    }
    
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
}



