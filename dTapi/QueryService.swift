//
//  QueryService.swift
//  dTapi
//
//  Created by ITA student on 10/12/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation

class QueryService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Track]?, String) -> ()
    
    // 1
    let defaultSession = URLSession(configuration: .default)
    // 2
    var dataTask: URLSessionDataTask?
    var tracks: [Track] = []
    var errorMessage = ""
    
    func getSearchResults(completion: @escaping QueryResult) {
        // 1
        dataTask?.cancel()
        // 2
        if var urlComponents = URLComponents(string: "http://vps9615.hyperhost.name/subject/getRecords") {
            //urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
            // 3
            guard let url = urlComponents.url else { return }
            // 4
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                // 5
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    print(response)
                    //self.updateSearchResults(data)
                    // 6
                    DispatchQueue.main.async {
                        completion(self.tracks, self.errorMessage)
                    }
                }
            }
            // 7
            dataTask?.resume()
        }
    }
    
}
