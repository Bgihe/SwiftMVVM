//
//  DataDecoder.swift
//  MapleTV
//
//  Created by 廖冠翰 on 2017/11/17.
//  Copyright © 2017年 Henry. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataDecoder: NSObject {
    
    /** 將array塞進Model */
    public class func dictionaryArrayDecode<T:Decodable>(_ type:T.Type,dictArray:[JSON]) -> [T]? {
        
        var models = [T]()
        
        for dict in dictArray {
            let dataModel = DataDecoder.dictionaryDecode(type.self, dict: dict.dictionaryObject!)
            
            if let model = dataModel {
                models.append(model)
            }
        }
        
        return models
    }

    /** 將dictionary塞進Model */
    public class func dictionaryDecode<T:Decodable>(_ type:T.Type,dict:[String:Any]) -> T? {
        
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        do {
            let object = try JSONDecoder().decode(T.self, from: jsonData)
            
            return object
        } catch  {
            
            print(error)
            return nil
        }
    }
    
    /** 將dictionary array轉換為字串 */
    public class func serializationDictionaryArray(_ dictArray:[[String:Any]]) -> String? {
        
   
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictArray, options: .prettyPrinted)
            
            var jsonString = String(data: jsonData, encoding: .utf8)!
            jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
            jsonString = jsonString.replacingOccurrences(of: " ", with: "")
            
            return jsonString
            
        } catch let error {
            
            print(error)
            
            return nil
        }

    }
    
    /** 將dictionary轉換為字串 */
    public class func serializationDictionary(_ dict:[String:Any]) -> String? {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            return String(data: jsonData, encoding: .utf8)
            
        } catch let error {
            
            print(error)
            
            return nil
        }
    }
}
