//
//  RequestService.swift
//  Assignment
//
//  Created by Niranjan on 18/06/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import Foundation

 enum NetworkError: Error {
    case domainError
    case decodingError
}
final class RequestService {
    
       let movieUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
       let defaultSession = URLSession(configuration: .default)
       var dataTask: URLSessionDataTask?
       var errorMessage = ""
    
    func loadData(completion: @escaping (Result<FeedsModel,ErrorResult>) -> Void) {
    dataTask?.cancel()
              guard let url = URL(string: movieUrl) else {
                     return
                 }
        let request = RequestFactory.request(method: .GET, url: url)
             
              let task = defaultSession.dataTask(with: request) { (data, _, error) in
                  if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                      return
                  }
                    if let data = data {
                    let value = FeedsModel.parseObject(data: data)
                    completion(value)
                 }
           }
              task.resume()
          }
}
