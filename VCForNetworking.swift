//
//  VCForNetworking.swift
//  FloridaManToday
//
//  Created by Logan Melton on 4/27/22.
//

import UIKit

struct NetworkData: Decodable {
  var name: String
}

class NetworkingVC: UIViewController {
  
  let dataProvider = DataProvider()
  
  var returnedData: NetworkData?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getData()
  }
}

extension NetworkingVC {
  func getData() {
    dataProvider.methodFromDataProvider() { [weak self] (dataResult: Result<NetworkData, Error>) in
      guard let self = self else { return }
      switch dataResult {
        case .success(let model):
          let returnedData = model as NetworkData
        // Can further unwrap optionals or manipulate data as needed
        case .failure(let error):
          print(error)
      }
    }
  }
}
