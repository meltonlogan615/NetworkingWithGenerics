//
//  NetworkAccess.swift
//  Networking With Generics
//
//

// *** MODIFICATIONS GENERALLY NOT REQUIRED ***


import Foundation

// Sets up possible errors
enum NetworkError: Error {
  case networkError
  case responseError
  case invalidData
}

// allows for the use of enum values in completion handlers
typealias NetworkCompletion = (Result<Data, NetworkError>) -> Void

struct NetworkAccess {
  private var url: URL
  private var session: URLSession
  
  // by setting session to Type URLSession with the default value of URLSession.shared, will reduce future duplication
  init(url: URL, session: URLSession = URLSession.shared) {
    self.url = url
    self.session = session
  }
  
  func fetchData(with completion: @escaping NetworkCompletion) {
    let task = session.dataTask(with: url) { (data, response, error) in
      // if error is received, will return a networkError
      guard error == nil else {
        completion(.failure(.networkError))
        return
      }
      
      // if network response can be down cast asa HTTPURLResponse && is not statusCode 200, will return a responseError
      guard let networkResponse = response as? HTTPURLResponse, networkResponse.statusCode == 200 else {
        completion(.failure(.responseError))
        print(self.url)
        return
      }
      
      // if receivedData can not be set as the response info, will return invalidData error
      guard let receivedData = data else {
        completion(.failure(.invalidData))
        return
      }
      completion(.success(receivedData))
    }
    task.resume()
  }
}

