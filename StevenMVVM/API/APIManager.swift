//
//  APIManager.swift
//  InfinityAdventureGame
//
//  Created by steven on 2020/6/1.
//  Copyright © 2020 steven. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

// TransService API
public let API_OIL = "https://raw.githubusercontent.com/Bgihe/oiloiloil/master/oil.json"  // 油價

class APIManager: NSObject {
    public let loadingView = LoadingView()
    
    /// Post Json請求
    public func sendPostJsonRequest(parameters: [String:Any]?, url: String, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void, statusCode: @escaping (NSInteger) -> Void, isLoading: Bool = true) {
        if isLoading {
            loadingView.showLoading(nil)
        }
        Alamofire.request(URL(string: url)!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            switch response.result {
            case .success:
                success(JSON(response.result.value!))
            case .failure(let error):
                failure(error)
                statusCode(response.response?.statusCode ?? 400)
            }
            if isLoading {
                self.loadingView.hideLoading()
            }
        }
    }
    
    /// Post請求
    public func sendPostRequest(parameters: [String: Any]?, url: String, success: @escaping (JSON) -> Void, failure:@escaping (Error) -> Void, statusCode: @escaping (NSInteger) -> Void, isLoading: Bool = true) {
        if isLoading {
            loadingView.showLoading(nil)
        }
        let headers = ["":""]
        Alamofire.request(URL(string: url)!, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                success(JSON(response.result.value!))
            case .failure(let error):
                failure(error)
                statusCode(response.response?.statusCode ?? 400)
            }
            if isLoading {
                self.loadingView.hideLoading()
            }
        }
    }

    /// GET請求
    public func sendGetRequest (parameters: [String: Any]?, url: String, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void, isLoading: Bool = true) {
        if isLoading {
            loadingView.showLoading(nil)
        }
        
        let mParameters = setBaseValue(parameters!)
        let headers = ["":""]
        Alamofire.request(URL(string: url)!, method: .get, parameters: mParameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                success(JSON(response.result.value!))
            case .failure(let error):
                failure(error)
            }
            if isLoading {
                self.loadingView.hideLoading()
            }
        }
    }

    /// GET請求
    func sendGetRequestNew(parameters: [String:Any]?, url: String, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void, isLoading: Bool = true) {
        if isLoading {
            loadingView.showLoading(nil)
        }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        let mParameters = setBaseValue(parameters!)
        Alamofire.request(URL(string: url)!, method: .get, parameters: mParameters, headers: headers).responseData { (response) in
            //            print("url:", url)
            switch response.result {
            case .success:
                print("response:", response)
                success((response.data!))
            case .failure(let error):
                failure(error)
            }
            
            if isLoading {
                self.loadingView.hideLoading()
            }
        }
    }
    
    /// 設置基礎參數
    func setBaseValue(_ parameters: [String: Any]) -> [String: Any] {
        var newParameters = parameters
        newParameters["UnitId"] = "QcbUEzN6E6DL"
        return newParameters
    }

    /// 回傳狀態
    public func successStatus(of response:JSON, andVC:UIViewController) -> Bool {
        var status = false
        if response["code"].intValue != 200 {
            Alert.shared.showAlertView(of: "訊息", andMessage:response["msg"].stringValue, andVC: andVC)
        }else {
            status = true
        }
        return status
    }
    
    @objc func errorConfirmBtnPress(sender:UIButton) {
        let lineURL = URL(string: "itms-apps://itunes.apple.com/app/id1485196303")!
        UIApplication.shared.open(lineURL, options: [:], completionHandler: nil)
    }
 }

//MARK: - Instance
extension APIManager {

    /// 實例化
    public class var shared:APIManager {
        struct Static {
            static let instance:APIManager = APIManager()
        }
        return Static.instance
    }
 }

extension APIManager:URLSessionDelegate {

    //    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    //        var err: OSStatus
    //        var disposition: Foundation.URLSession.AuthChallengeDisposition = Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling
    //        var trustResult: SecTrustResultType = .invalid
    //        var credential: URLCredential? = nil
    //        //獲取server 信任憑證
    //        let serverTrust: SecTrust = challenge.protectionSpace.serverTrust!
    //        //將讀取的憑證設置為serverTrust跟憑證
    //        err = SecTrustSetAnchorCertificates(serverTrust, trustedCertList)
    //
    //        if err == noErr {
    //            //通過本地的憑證來驗證服務器的憑證是否可信
    //            err = SecTrustEvaluate(serverTrust, &trustResult)
    //        }
    //        if err == errSecSuccess && (trustResult == .proceed || trustResult == .unspecified) {
    //            //認證成功
    //            disposition = Foundation.URLSession.AuthChallengeDisposition.useCredential
    //            credential = URLCredential(trust: serverTrust)
    //        } else {
    //            disposition = Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge
    //        }
    //        completionHandler(disposition, credential)
    //    }
 }
