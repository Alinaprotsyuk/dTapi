//
//  TableViewController.swift
//  dTapi
//
//  Created by ITA student on 10/13/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    var records = [Records]()
    
    let queryService = QueryService()
    
    var filteredData = [Records]()
    
    var inSearchMode = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showRecords()
        searchBar.returnKeyType = UIReturnKeyType.done
        
        //let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name","Description","Id"]
        searchBar.selectedScopeButtonIndex = 0
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            inSearchMode = true
            switch  searchBar.selectedScopeButtonIndex {
            case 0:
                filteredData = records.filter({$0.name == searchBar.text})
            case 1:
                for item in records{
                    if item.description.contains(searchBar.text!) {
                        filteredData.append(item)
                    }
                }
                
                    //records.filter({$0.description == searchBar.text})
            case 2:
                filteredData = records.filter({$0.id == searchBar.text})
            default:
                print("No match")
            }
            
            tableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        showRecords()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showRecords() {
        Records.getRecords(sufix: "getRecords", completion: { (results:[Records]?) in
            
            if let subjectData = results {
                self.records = subjectData
            
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    @IBAction func updateRecords(_ sender: UIBarButtonItem) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if inSearchMode {
            
            return filteredData.count
        }
        
        return records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if inSearchMode {
            cell.textLabel?.text = filteredData[indexPath.row].id + " " + filteredData[indexPath.row].name
            cell.detailTextLabel?.text = filteredData[indexPath.row].description
            
        } else {
            cell.textLabel?.text = records[indexPath.row].id + " " + records[indexPath.row].name
            cell.detailTextLabel?.text = records[indexPath.row].description
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = records[indexPath.row].id
            print(item)
            queryService.deleteReguest(sufix: "subject/del/\(item)")
            records.remove(at: indexPath.row)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           // prepare(for: "updateRequest", sender: <#T##Any?#>)
            let storyboard = UIStoryboard(name: "Another", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Third") as? AddNewRecordViewController
            vc!.subjectId = records[indexPath.row].id
            vc!.subjectName.text = records[indexPath.row].name
            vc!.subjectDescription.text = records[indexPath.row].description
            self.navigationController?.pushViewController(vc!,animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        <#code#>
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        performSegue(withIdentifier: "updateRequest" , sender: nil)
        
    }*/
    

}
