//
//  Utility.swift
//  CodeTest
//
//  Created by Gaurav Bangad on 15/08/20.
//  Copyright © 2020 Gaurav Bangad. All rights reserved.
//

import UIKit

class Utility: NSObject {

    var indicator: UIActivityIndicatorView! = nil

    static let sharedInstance = Utility()
    
    func addIndicator(view:UIView) -> Void{
       indicator = UIActivityIndicatorView(style: .medium)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        indicator.color = .lightGray
        view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
        indicator.startAnimating()
    }
    
}
