//
//  LoadingView.swift
//  TTL
//
//  Created by 廖冠翰 on 2018/3/19.
//  Copyright © 2018年 whatsmedia. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .gray
        return activityIndicator
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.frame = CGRect.init(x: -100, y: -100, width: 100, height: 100)
        logoImageView.image = UIImage.init(named: "inviteRegisteredIcon")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.alpha = 0.0
        return logoImageView
    }()
    
    var displayView:UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }
    
    fileprivate func commonInit() {
        
        backgroundColor = UIColor.clear
        addSubview(logoImageView)
        addSubview(activityIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if displayView != nil {
            activityIndicator.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5 - 64)
        }else {
            activityIndicator.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        }
        
        logoImageView.center = activityIndicator.center
    }
}

//MARK: - Public
extension LoadingView {
    public func showLoading(_ target:UIView?) {
        displayView = target
        
        if let targetView = displayView {
            frame = targetView.bounds
            targetView.addSubview(self)
        }else {
           frame = UIApplication.shared.keyWindow!.bounds
           UIApplication.shared.keyWindow?.addSubview(self)
        }
        
        activityIndicator.startAnimating()
    }
    
    public func hideLoading() {
        removeFromSuperview()
    }
}
