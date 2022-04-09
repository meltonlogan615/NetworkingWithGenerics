//
//  JsonParser.swift
//  Networking With Generics
//
//

// *** MODIFICATIONS GENERALLY NOT REQUIRED ***

import Foundation

struct JsonParser {
  
  private var data: Data
  private var decoder: JSONDecoder
  
  // by setting decoder to Type JSONDecoder with the default value of an initialized JSONDecoder, will reduce future duplication
  init(data: Data, decoder: JSONDecoder = JSONDecoder()) {
    self.data = data
    self.decoder = decoder
  }
  
  func decode<T: Decodable>() -> Result<T, Error> {
    do {
      let decodedObject = try decoder.decode(T.self, from: data)
      return .success(decodedObject)
    } catch {
      return .failure(error)
    }
    
  }
}

