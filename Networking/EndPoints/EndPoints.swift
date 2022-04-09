//
//  EndPoints.swift
//  Networking with Generics
//
//  Created by Logan Melton on 4/3/22.
//

// For a new project, review the API Documentation you plan to use to determin the properties that you will need in order to complete the URL

import Foundation
struct EndPoints {
  private let baseURL = <#BaseURL#>
  private var searchType = <#AdditionalParameter#> // if required
  private let apiKey = <#APIKey#> // if required
  var query: String? // Can be any Type
}

// MARK: - Computed Property to build URL for Recipe Search
extension EndPoints {
  var endpointURL: URL {
    guard let query = query else { fatalError("Endpoint URL Failed") }
    let completedURL = URL(string: <#AssembledURL#>)
 // Example:
 //   let completedURL = URL(string: "\(baseURL)\(searchType)?apiKey=\(apiKey)&query=\(query)")
//    completedURL = "https://api.spoonacular.com/recipes/complexSearch?apiKey=123&query=bacon"
    guard let url = completedURL else {
      preconditionFailure("Invalid URL: \(String(describing: completedURL))")
    }
    return url
  }
}

extension EndPoints {
// Search METHOD
  func getFood(for searched: String) -> EndPoints {
    return EndPoints(query: searched)
  }
}

// Later, if additional ENDPOINTS or API provided functionality added, you will ned to futher extend EndPoints to generate the new Computed Property  & create a new METHOD to recive the data that will be passed back in.
