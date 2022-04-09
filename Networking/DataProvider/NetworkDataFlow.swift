//
//  NetworkDataFlow.swift
//  Networking With Generics
//
//

// *** MODIFICATIONS GENERALLY NOT REQUIRED ***

import Foundation

class NetworkDataFlow {
  
  //  MARK: - This method is in charge of the flow - getting data from the network and parsing it into model data
  public func getData<T: Decodable>(for url: URL, with completion: @escaping (Result<T, Error>) -> Void) {
    fetchNetworkData(at: url) { [weak self] (networkResult: Result<Data, Error>) in
      guard let self = self else { return }
      switch networkResult {
        case .success(let data):
          self.parseNetworkData(data: data) { (parserResult: Result<T, Error>) in
            DispatchQueue.main.async {
              switch parserResult {
                case .success(let items):
                  completion(.success(items)) // parse success
                case .failure(let error):
                  completion(.failure(error)) // parse error
              }
            }
          }
        case .failure(let error):
          DispatchQueue.main.async {
            completion(.failure(error)) // network failure
          }
      }
    }
  }
  
  //  MARK: - Retrieves the data from the network
  private func fetchNetworkData(at url: URL, with completion: @escaping (Result<Data, Error>) -> Void) {
    let networkAccess = NetworkAccess(url: url)
    networkAccess.fetchData() { (result) in
      switch result {
        case .success(let data):
          completion(.success(data))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  //  MARK: - Parses the data
  private func parseNetworkData<T: Decodable>(data: Data, with completion: @escaping (Result<T, Error>) -> Void) {
    let jsonParser = JsonParser(data: data)
    let result: Result<T, Error> = jsonParser.decode()
    completion(result)
  }
}
