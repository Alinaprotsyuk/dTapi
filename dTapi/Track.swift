//
//  Records.swift
//  dTapi
//
//  Created by ITA student on 10/11/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//
import Foundation

/*enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

struct RecordsItems : Codable {
    var id : Int
    var name : String
    var description : String
    
    init?(json: [String: Any]) {
        guard let id = json["subject_id"] as? Int,
            let name = json["subject_name"] as? String,
            let description = json["subject_description"] as? String else {
                return nil
        }
        self.id = id
        self.name = name
        self.description = description
    }
    
    static func endpointForID() -> String {
        return "http://vps9615.hyperhost.name/subject/getRecords"
    }
    
    static func endpointForTodos() -> String {
        return "http://vps9615.hyperhost.name/subject/getRecords"
    }
    
    static func allTodos(completionHandler: @escaping ([RecordsItems]?, Error?) -> Void) {
        let endpoint = RecordsItems.endpointForTodos()
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let todos = try decoder.decode([RecordsItems].self, from: responseData)
                completionHandler(todos, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}*/
import Foundation.NSURL

// Query service creates Track objects
class Track {
    
    var id : String
    var name : String
    var description : String
    
    init(id : String, name : String, description: String){
        self.id = id
        self.name = name
        self.description = description
    }
    
}

