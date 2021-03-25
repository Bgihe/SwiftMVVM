//
//  OilViewModel.swift
//  StevenMVVM
//
//  Created by steven on 2021/3/25.
//

import SwiftyJSON
import Foundation

class OilViewModel {
    var oilModelList = Observable<[OilModel]>(value: [])

    func getOilJson() {
        OilManger.apiGetOilJson(parameters: ["": ""], success: {(response) in
            do {
                let json: JSON = try JSON(data: response)
                let jsonList = json.arrayValue
                self.oilModelList.value = DataDecoder.dictionaryArrayDecode(OilModel.self, dictArray: jsonList) ?? [OilModel]()
            } catch {
            
            }
        }, failure: {_ in}, statusCode: {_ in})
    }
}
