//
//  DataProvider.swift
//  Networking With Generics
//
//

import Foundation
import UIKit


class DataProvider  {
  
  private let networkDataFlow = NetworkDataFlow()
  private let endpoints = EndPoints()
  
  var query: String?
  
  // search by STRING value that is an OPTIONAL
  func <#MethodName#><T: Decodable>(for: String, completion: @escaping (Result<T, Error>) -> Void) {
    if let query = query {
      let <#NewObject#> = endpoints.<#EndPointMethod#>(for: query)
      networkDataFlow.getData(for: <#NewObject#>.endpointURL) { (result: Result<T, Error>) in
        completion(result)
      }
    }
  }
  
  // search by STRING value that is NOT an OPTIONAL
  func <#MethodName#><T: Decodable>(for: String, completion: @escaping (Result<T, Error>) -> Void) {
    let <#NewObject#> = endpoints.<#EndPointMethod#>(for: query)
    networkDataFlow.getData(for: <#NewObject#>.endpointURL) { (result: Result<T, Error>) in
      completion(result)
    }
  }
  
  // If additional networking calls are required, add a new value below query and create a new method with the corresponding METHODS and VALUES below
  
  
}

