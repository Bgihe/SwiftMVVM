//
//  OilManger.swift
//  OilWidget
//
//  Created by steven on 2021/3/24.
//

import UIKit
import SwiftyJSON

class OilManger: APIManager {

}

//MARK: - Public
extension OilManger {
    /// 實例化
    public class var sharedInstance: OilManger {
        struct Static {
            static let instance: OilManger = OilManger()
        }
        return Static.instance
    }
}

//MARK: - API
extension OilManger {
    public class func apiGetOilJson(parameters: [String : Any],
                                         success: @escaping (Data) -> Void,
                                         failure: @escaping (Error) -> Void,
                                         statusCode: @escaping (NSInteger) -> Void) {
        APIManager.shared.sendGetRequestNew(parameters: parameters, url: API_OIL, success: success, failure: failure, isLoading: true)
    }
}
