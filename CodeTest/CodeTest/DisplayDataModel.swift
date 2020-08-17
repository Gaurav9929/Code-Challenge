//
//  DisplayDataModel.swift
//  CodeTest
//
//  Created by Gaurav Bangad on 13/08/20.
//  Copyright © 2020 Gaurav Bangad. All rights reserved.
//

import UIKit

class DisplayDataModel: NSObject {
    let id:String?
    let type:String?
    let date:String?
    let data:String?
    
     init(dictionary:[String:Any]) {
        self.id =  dictionary["id"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.data = dictionary["data"] as? String ?? ""

    }
}
