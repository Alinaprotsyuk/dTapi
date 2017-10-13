//
//  SecondViewController.swift
//  dTapi
//
//  Created by ITA student on 10/11/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit



class SecondViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   
    var records = [Track]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onGetTapped()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   func onGetTapped() {
        var tracks = [Track]()
        guard let url = URL(string: "http://vps9615.hyperhost.name/subject/getRecords") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                //print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
                    //print("There are =  \(json.count)")
                    //print (json)
                    for trackDictionary in json {
                        if let trackDictionary = trackDictionary as? [String: Any],
                           let desc = trackDictionary["subject_description"] as? String ,
                            let id = trackDictionary["subject_id"] as? String,
                            let name = trackDictionary["subject_name"] as? String {
                            tracks.append(Track(id : id, name : name, description: desc))
                        } else {
                            print( "Problem parsing trackDictionary\n")
                        }
                        self.records = tracks
                    }
                    DispatchQueue.main.async {
                       self.table.reloadData()
                    }
                    
                }
                    catch {
                    print(error)
                }
                print(tracks.count)
                for item in tracks {
                    print(item.name)
                    print(" ")
                }
                
           }
            
        }.resume()
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



