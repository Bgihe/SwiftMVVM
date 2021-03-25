//
//  Alert.swift
//  Taitra
//
//  Created by Ruby on 2019/6/8.
//  Copyright © 2019 Ruby. All rights reserved.
//

import UIKit

class Alert: NSObject {
    public func showAlertView(of title:String, andMessage:String, andVC:UIViewController){
        let alert = UIAlertController(title: title, message: andMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        andVC.present(alert, animated: true, completion: nil)
    }
    
    public func showAlertView(of title:String, andMessage:String, andVC:UIViewController, okAction:@escaping () -> Void){
        let alert = UIAlertController(title: title, message: andMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default) { (action) in
            okAction()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        andVC.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Instance
extension Alert {
    
    /// 實例化
    public class var shared:Alert {
        struct Static {
            static let instance:Alert = Alert()
        }
        return Static.instance
    }
}
